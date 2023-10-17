# —————————————————————————————————————————————— #
#                      base                      #
# —————————————————————————————————————————————— #

FROM ubuntu:jammy-20231004 as base

USER root

RUN set -e \
  && export DEBIAN_FRONTEND=noninteractive \
  && echo "--- Install packages ---" \
  && apt-get update -qq \
  && apt-get install -y -qq --no-install-recommends \
    git=1:2.34.1-* \
    locales=2.35-* \
  && echo "--- Add locales ---" \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && echo "--- Clean ---" \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.utf8
ENV USERNAME=app-user
ARG GROUPNAME=${USERNAME}
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ENV HOME=/home/${USERNAME}
ENV APP_DIR=/app

RUN set -e \
  && echo "--- Add username and groupname ---" \
  && groupadd --gid ${USER_GID} ${GROUPNAME} \
  && useradd --uid ${USER_UID} --gid ${USER_GID} --shell /bin/bash \
    --create-home ${USERNAME} \
  && echo "--- Create project directory and add ownership ---" \
  && mkdir ${APP_DIR} \
  && chown ${USERNAME}: ${APP_DIR}

USER ${USERNAME}

WORKDIR ${APP_DIR}

CMD [ "bash" ]

# —————————————————————————————————————————————— #
#                       ci                       #
# —————————————————————————————————————————————— #

FROM koalaman/shellcheck:v0.9.0 as shellcheck
FROM mvdan/shfmt:v3.7.0 as shfmt
FROM hadolint/hadolint:v2.12.0 as hadolint
FROM node:18.18.2-bullseye as node

FROM base as ci

USER root

RUN set -e \
  && export DEBIAN_FRONTEND=noninteractive \
  && echo "--- Install packages ---" \
  && apt-get update -qq \
  && apt-get install -y -qq --no-install-recommends \
    parallel=20210822+* \
  && echo "--- Clean ---" \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

# Add shellcheck
COPY --from=shellcheck --chown=root /bin/shellcheck /usr/local/bin/

# Add shfmt
COPY --from=shfmt --chown=root /bin/shfmt /usr/local/bin/

# Add hadolint
COPY --from=hadolint --chown=root /bin/hadolint /usr/local/bin/

# Add NodeJS (without yarn)
COPY --from=node --chown=root /usr/local/bin /usr/local/bin/
COPY --from=node --chown=root /usr/local/include /usr/local/include/
COPY --from=node --chown=root /usr/local/lib /usr/local/lib/
COPY --from=node --chown=root /usr/local/share /usr/local/share/
# Remove dead symbolic links from yarn
RUN find /usr/local/bin/. -xtype l -exec rm {} \; 2>/dev/null

USER ${USERNAME}

# —————————————————————————————————————————————— #
#                       dev                      #
# —————————————————————————————————————————————— #

FROM ci as dev

USER root

RUN set -e \
  && export DEBIAN_FRONTEND=noninteractive \
  && echo "--- Install packages ---" \
  && apt-get update -qq \
  && apt-get install -y -qq --no-install-recommends \
    ca-certificates=20230311ubuntu0.22.04.1 \
    gnupg2=2.2.27-* \
    openssh-client=1:8.9p1-* \
    sudo=1.9.9-* \
  && echo "--- Give sudo rights to 'USERNAME' ---" \
  && echo "${USERNAME}" ALL=\(root\) NOPASSWD:ALL >/etc/sudoers.d/"${USERNAME}" \
  && chmod 0440 /etc/sudoers.d/"${USERNAME}" \
  && echo "--- Clean ---" \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

USER ${USERNAME}

# —————————————————————————————————————————————— #
#                     vscode                     #
# —————————————————————————————————————————————— #

FROM dev as vscode

WORKDIR ${HOME}

RUN set -e \
  && mkdir -p .vscode-server/extensions \
    .vscode-server-insiders/extensions

WORKDIR ${APP_DIR}
