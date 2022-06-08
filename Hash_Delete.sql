SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
ALTER proc Hash_Delete
(@_key bigint)
as
begin

    declare @Hash_Table table
    (
        _id bigint
      , _key bigint
      , _value nvarchar(4000)
    );


    if exists
    (
        select  1
        from    dbo.Hash_Table as ht
        where   ht._id = dbo.Hash_Function (@_key)
                and  ht._key = @_key
                and ht._value is not null
    )
    begin

        insert into @Hash_Table
        select  top (1)
                ht._id, ht._key, ht._value
        from    dbo.Hash_Table as ht
        where   ht._id = dbo.Hash_Function (@_key) and  ht._value is not null;



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
                where   ht._id = @indis
                        and
                        (
                            ht._key = @_key or  ht._key is null
                        )
            )
            begin
                break;
            end;

            set @indis = @indis + 1;

        end;

        insert into @Hash_Table
             (_id, _key, _value)
        select  ht._id, ht._key, ht._value
        from    dbo.Hash_Table ht
        where   ht._id = @indis;



    end;

    update           ht
	set ht._key=null,
	ht._value=null
    from            dbo.Hash_Table as ht
        inner join  @Hash_Table    as tmp
           on tmp._id = ht._id;


end;
GO

