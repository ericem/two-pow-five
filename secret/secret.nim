# cerner_2^5_2019
import os
import osproc
import strformat
import streams
import terminal
var user = getEnv("USER")
var secrets_keychain = getEnv("SECRETS_KEYCHAIN", "secrets.keychain")
var cmd = paramStr(1)
case cmd
of "list":
  var secret_list = fmt"security dump-keychain {secrets_keychain} | grep svce | awk -F= '{{print $2}}' | tr -d " & """\""""
  var (keys, _) = execCmdEx(secret_list)
  echo keys
of "copy":
  var secret_name = paramStr(2)
  var (secret_value, _) = execCmdEx(fmt"security find-generic-password -a {user} -s '{secret_name}' -w {secrets_keychain}")
  var pbcopy = startProcess("/usr/bin/pbcopy")
  var pbcopy_stdin = inputStream(pbcopy)
  writeLine(pbcopy_stdin, secret_value)
  pbcopy.close()
of "set":
  var secret_name = paramStr(2)
  var password = readPasswordFromStdin("Password: ")
  var verify_password = readPasswordFromStdin("Retype Password: ")
  while verify_password != password:
    echo "Passwords do not match"
    verify_password = readPasswordFromStdin("Retype Password: ")
  var (_, _) = execCmdEx(fmt"security add-generic-password -D secret -U -a {user} -s '{secret_name}' -w '{password}' -w {secrets_keychain}")
else:
  echo "Unknown command " & cmd & "."
