# Docker

## `app` service

### Environment variables

<!-- markdownlint-disable no-inline-html-->

<table>
  <tr>
    <th>Name</th>
    <th>Description</th>
    <th align="center">Custom</th>
    <th>Possible value(s)</th>
  </tr>
  <tr>
    <td><code>CI</code></td>
    <td>Check if <code>./run</code> is executed on a CI environment.</td>
    <td align="center">✅</td>
    <td><code>true</code> or <code>false</code></td>
  </tr>
  <tr>
    <td><code>INSIDE_DOCKER</code></td>
    <td>Check if <code>./run</code> is executed in a docker container.</td>
    <td align="center">✅</td>
    <td><code>true</code> or <code>false</code></td>
  </tr>
  <tr>
    <td><code>LANG</code></td>
    <td>System variable for locales.</td>
    <td align="center">❌</td>
    <td>
      <ul>
        <li><code>en_US.UTF-8</code> (recommended)</li>
        <li><code>C</code></li>
        <li><code>C.UTF-8</code></li>
        <li><code>POSIX</code></li>
      </ul>
    </td>
  </tr>
</table>

<!-- markdownlint-enable  -->
