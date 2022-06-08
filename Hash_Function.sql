create function Hash_Function
(
    @_key as INT
)
returns bigint
as
begin
    declare @hash_key bigint;
    set @hash_key = @_key % 27;
    return @hash_key;
end;