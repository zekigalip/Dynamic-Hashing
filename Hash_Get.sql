alter function Hash_Get
(
    @_key bigint
)
returns @Hash_Table table (
       	_id bigint,
		_key bigint,
		_value nvarchar(4000)
    ) 
as
begin 


    if exists
    (
        select  1
        from    dbo.Hash_Table as ht
        where   ht._id = dbo.Hash_Function (@_key) and ht._key = @_key and  ht._value is not null
    )
    begin
	   	 
		 insert into @Hash_Table
            select top (1)  ht._id, ht._key, ht._value
            from    dbo.Hash_Table as ht
            where   ht._id = dbo.Hash_Function (@_key)
                    and ht._key = @_key
        

		return;

    end;
    else
    begin

       declare @donusSayisi bigint = 0;
        declare @indis bigint;
        select  @indis = dbo.Hash_Function (@_key);

     

        while 1 = 1
        begin
            --printf("%d %d %d \n",a[indis].k, data.k, indis);
        
            if (@indis >= 27)
            begin
                if (@donusSayisi >= 1)
                begin
                    return;
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

     INSERT INTO @Hash_Table
          (_id, _key, _value)     
            select  ht._id, ht._key, ht._value
            from    dbo.Hash_Table ht
            where   ht._id = @indis
			and ht._key = @_key

			return;


    end;

	return;

end
