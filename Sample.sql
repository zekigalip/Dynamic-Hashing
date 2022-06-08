truncate table dbo.Hash_Table

declare @i bigint
set @i =1


while @i<28
begin
	
	INSERT INTO dbo.Hash_Table
	     (_id, _key, _value)
	values
	(   @i    -- _id - bigint
	  , null    -- _key - bigint
	  , null    -- _value - nvarchar(4000)
	    )

		set @i = @i + 1
end 

exec dbo.Hash_Put @_key = 1     -- bigint
                , @_value = N'6666' -- nvarchar(4000)

exec dbo.Hash_Put @_key = 100     -- bigint
                , @_value = N'7777' -- nvarchar(4000)

exec dbo.Hash_Put @_key = 28     -- bigint
                , @_value = N'9999' -- nvarchar(4000)

--exec dbo.Hash_Put @_key = 28     -- bigint
--                , @_value = N'4234' -- nvarchar(4000)


--select * from  dbo.Hash_get (28)

--exec Hash_Delete 100

select * from  dbo.Hash_get (100)
--select * from  dbo.Hash_get (28)
				

SELECT * FROM dbo.Hash_Table as ht
