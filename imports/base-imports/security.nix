{...}:
{
    security.sudo.execWheelOnly = true;     # only allow sudo for wheel group
    # security.sudo.enable = false;         # disable sudo all together

    security.auditd.enable = true;
    security.audit.enable = true;
    security.audit.rules = [
        "-a exit,always -F arch=b64 -S execve" #log whenever a program is attempted to be run
    ];

}