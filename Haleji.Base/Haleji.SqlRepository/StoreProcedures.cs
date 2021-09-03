using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Irada.Common.DAL;
using System.Data.SqlClient;

namespace Haleji.SqlRepository
{
    internal struct StoredProcedures
    {
        internal struct Location
        {
            public const string Insert = "spInsertLocation";
            public const string Update = "spUpdateLocation";
            public const string Delete = "spDeleteLocation";
            public const string GetAll = "spGetAllLocation";
            public const string Search = "spSearchLocation";

            public const string LocationId = "@LocationId";
            public const string LocationName = "@LocationName";

            public static SqlParameter GetLocationId(object id)
            {
                return new SqlParameter(LocationId, id);
            }

            public static SqlParameter GetLocationName(object name)
            {
                return new SqlParameter(LocationName, name);
            }
        }

        public struct Item
        {
            public const string Insert = "spInsertItem";
            public const string Update = "spUpdateItem";
            public const string Delete = "spDeleteItem";
            public const string GetAll = "spGetAllItem";
            public const string Search = "spSearchItem";

            private const string ItemId = "@ItemId";
            private const string ItemName = "@ItemName";
            private const string ItemDesc = "@ItemDescription";

            public static SqlParameter GetItemId(object v)
            {
                return SQLHelper.CreateSqlParam(ItemId, v);
            }

            public static SqlParameter GetItemName(object v)
            {
                return SQLHelper.CreateSqlParam(ItemName, v);
            }

            public static SqlParameter GetItemDescr(object v)
            {
                return SQLHelper.CreateSqlParam(ItemDesc, v);
            }

        }
    }
}
