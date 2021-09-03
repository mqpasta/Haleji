using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using Irada.Common.DAL;

namespace Haleji.SqlRepository
{
    public class SqlLocationRepository : ILocationRepository
    {
        string _constr;

        #region FIELDS
        const string LOCATIONID = "LocationId";
        const string LOCATIONNAME = "LocationName";
        #endregion

        public SqlLocationRepository()
        {
            _constr = SQLHelper.ConnectionString;
        }
        public void Add(Location entity)
        {
            List<SqlParameter> pars = new List<SqlParameter>();
            pars.Add(StoredProcedures.Location.GetLocationName(entity.LocationName));

            using (SqlConnection con = new SqlConnection(_constr))
            {       
                con.Open();
                var id = SQLHelper.ExecuteScalar(con, StoredProcedures.Location.Insert, pars.ToArray());
                con.Close();

                entity.LocationId = Convert.ToInt32(id);
            }
        }

        public IEnumerable<Location> GetAll()
        {
            List<Location> locations = new List<Location>();
            List<SqlParameter> parameters = new List<SqlParameter>();

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Location.GetAll, parameters.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        locations.Add(ExtractRow(r));
                    }
                }
            }

            return locations;
        }

        private static Location ExtractRow(DataRow r)
        {
            return new Location()
            {
                LocationId = Convert.ToInt32(r[LOCATIONID]),
                LocationName = Convert.ToString(r[LOCATIONNAME])
            };
        }

        public Location GetById(long id)
        {
            Location location = new Location();
            using (SqlConnection con = new SqlConnection(_constr))
            {
                List<SqlParameter> p = new List<SqlParameter>();
                p.Add(StoredProcedures.Location.GetLocationId(id));

                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Location.Search, p.ToArray());
                con.Close();

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                    {
                        location = ExtractRow(r);
                    }
                }
            }

            return location;
        }

        public void Remove(Location entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(StoredProcedures.Location.GetLocationId(entity.LocationId));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Location.Delete, parameters.ToArray());
                con.Close();
            }
        }

        public void Update(Location entity)
        {
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(StoredProcedures.Location.GetLocationId(entity.LocationId));
            parameters.Add(StoredProcedures.Location.GetLocationName(entity.LocationName));

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Location.Update, parameters.ToArray());
                con.Close();
            }
        }
    }
}
