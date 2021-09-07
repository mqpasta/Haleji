﻿using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using Irada.Common.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Haleji.SqlRepository
{
    public class SqlMovementRepository : IMovementRepository
    {

        private string _constr = SQLHelper.ConnectionString;

        public void Add(Movement entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Movement.GetTransType(entity.TransactionTypeId),
                StoredProcedures.Movement.GetPersonId(entity.PersonId),
                StoredProcedures.Movement.GetLocationId(entity.LocationId),
                StoredProcedures.Movement.GetPurchaseId(entity.PurchaseId),
                StoredProcedures.Movement.GetMovDate(entity.MovDate),
                StoredProcedures.Movement.GetIsActive(entity.IsActive),
                StoredProcedures.Movement.GetParentMovement(entity.ParentMovementId)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Movement.Insert, pm.ToArray());
                con.Close();
            }
        }

        public IEnumerable<Movement> GetAll()
        {
            throw new NotImplementedException();
        }

        public List<Movement> GetAllInStock()
        {
            List<Movement> movements = GetAllMovements(StoredProcedures.TransType.InStock);

            return movements;
        }

        public List<Movement> GetAllIssue()
        {
            List<Movement> movements = GetAllMovements(StoredProcedures.TransType.Issueed);

            return movements;
        }

        private List<Movement> GetAllMovements(StoredProcedures.TransType type)
        {
            List<Movement> movements = new List<Movement>();
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Movement.GetTransType(Convert.ToInt32(type))
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Movement.Search, pm.ToArray());

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        movements.Add(ExtractRow(r));
                }
            }

            return movements;
        }

        private static Movement ExtractRow(DataRow r)
        {
            var p = r["PersonId"];
            var pname = r["Name"];
            var l = r["LocationId"];
            var lname = r["LocationName"];
            var pid = r["PurchaseId"];
            var iname = r["ItemName"];
            var parent = r["ParentMovementId"];

            return new Movement()
            {
                MovementId = Convert.ToInt64(r["MovementId"]),
                TransactionTypeId = Convert.ToUInt32(r["TransTypeId"]),
                MovDate = Convert.ToDateTime(r["MovDate"]),
                IsActive = Convert.ToBoolean(r["IsActive"]),
                PersonId = DBNull.Value.Equals(p) ? null : Convert.ToInt32(p),
                PersonName = DBNull.Value.Equals(pname) ? null : Convert.ToString(pname),
                LocationId = DBNull.Value.Equals(l) ? null : Convert.ToInt64(l),
                LocationName = DBNull.Value.Equals(lname) ? null : Convert.ToString(lname),
                PurchaseId = DBNull.Value.Equals(pid) ? null : Convert.ToInt64(pid),
                ItemName = DBNull.Value.Equals(iname) ? null : Convert.ToString(iname),
                ParentMovementId = DBNull.Value.Equals(parent) ? null : Convert.ToInt64(parent)
            };
        }

        public List<Movement> GetAllOutStock()
        {
            List<Movement> movements = GetAllMovements(StoredProcedures.TransType.OutStock);

            return movements;
        }

        public List<Movement> GetAllScrap()
        {
            List<Movement> movements = GetAllMovements(StoredProcedures.TransType.Scrap);

            return movements;
        }

        public Movement GetById(long id)
        {
            Movement movement = new();
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Movement.GetMovementId(id)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                DataSet ds = SQLHelper.LoadData(con, StoredProcedures.Movement.Search, pm.ToArray());

                if (ds.Tables.Count > 0)
                {
                    foreach (DataRow r in ds.Tables[0].Rows)
                        movement = ExtractRow(r);
                }
            }

            return movement;
        }

        public void Remove(Movement entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Movement.GetMovementId(entity.MovementId)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Movement.Update, pm.ToArray());
                con.Close();
            }
        }

        public void Update(Movement entity)
        {
            List<SqlParameter> pm = new()
            {
                StoredProcedures.Movement.GetMovementId(entity.MovementId),
                StoredProcedures.Movement.GetTransType(entity.TransactionTypeId),
                StoredProcedures.Movement.GetPersonId(entity.PersonId),
                StoredProcedures.Movement.GetLocationId(entity.LocationId),
                StoredProcedures.Movement.GetPurchaseId(entity.PurchaseId),
                StoredProcedures.Movement.GetMovDate(entity.MovDate),
                StoredProcedures.Movement.GetIsActive(entity.IsActive),
                StoredProcedures.Movement.GetParentMovement(entity.ParentMovementId)
            };

            using (SqlConnection con = new SqlConnection(_constr))
            {
                con.Open();
                SQLHelper.Execute(con, StoredProcedures.Movement.Update, pm.ToArray());
                con.Close();
            }
        }
    }
}
