using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
