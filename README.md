# devx
Automated personal dev environment setup for Windows 10 machines.
## Usage
On a non-administrative `PowerShell` instance:

```PowerShell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb devx.carlo.sh | iex
```

You will be prompted for your credentials several times during the proccess. 
