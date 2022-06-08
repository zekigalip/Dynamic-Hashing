alter proc dbo.Hash_Put
(
    @_key bigint, @_value nvarchar(4000)
)
as
begin

    if exists
    (
        select  1
        from    dbo.Hash_Table as ht
        where   ht._id = dbo.Hash_Function (@_key) and  ht._key is null
    )
    begin
		
		print 'Boþ'

        update  ht
        set     ht._key = @_key, ht._value = @_value
        from    dbo.Hash_Table ht
        where   ht._id = dbo.Hash_Function (@_key);

    end;
    else
    begin

        declare @donusSayisi bigint = 0;
        declare @indis bigint;
        select  @indis = dbo.Hash_Function (@_key);

        print 'Indis';
        print @indis;

        while 1 = 1
        begin
            --printf("%d %d %d \n",a[indis].k, data.k, indis);
            print @indis;

            if (@indis >= 27)
            begin
                if (@donusSayisi >= 1)
                begin
                    print ('hashtable dolu');
                    return -1;
                end;
                set @indis = @indis % 27;
                set @donusSayisi = @donusSayisi + 1;
            end;

            if exists
            (
                select  1
                from    dbo.Hash_Table as ht
                where   ht._id = @indis and (ht._key = @_key or ht._key is null)
            )
            begin
                break;
            end;

            set @indis = @indis + 1;

        end;

        print @indis;
		print 'Indis Update';

        update  ht
        set     ht._key = @_key, ht._value = @_value
        from    dbo.Hash_Table ht
        where   ht._id = @indis;

    end;

end;