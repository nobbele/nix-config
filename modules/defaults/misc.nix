{ den, lib, ... }:
{
    den.schema.user.classes = lib.mkDefault [ "homeManager" ];

    den.default.includes = [
        den.batteries.define-user
        den.batteries.hostname
    ];
}
