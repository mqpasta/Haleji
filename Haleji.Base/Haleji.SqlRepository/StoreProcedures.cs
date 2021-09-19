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
        internal enum TransType
        {
            InStock = 1,
            Issueed = 2,
            Scrap = 3,
            OutStock = 4,
            Receive = 5
        }

        public static class Movement
        {
            public const string Insert = "spInsertMovement";
            public const string Update = "spUpdateMovement";
            public const string Delete = "spDeleteMovement";
            public const string GetAll = "spGetAllMovement";
            public const string Search = "spSearchMovement";
            public const string Ledger = "spMovementLedger";

            public static SqlParameter GetMovementId(object v)
            {
                return SQLHelper.CreateSqlParam("@MovementId", v);
            }

            public static SqlParameter GetTransType(object v)
            {
                return SQLHelper.CreateSqlParam("@TransTypeId", v);
            }

            public static SqlParameter GetPersonId(object v)
            {
                return SQLHelper.CreateSqlParam("@PersonId", v);
            }

            public static SqlParameter GetLocationId(object v)
            {
                return SQLHelper.CreateSqlParam("@LocationId", v);
            }

            public static SqlParameter GetPurchaseId(object v)
            {
                return SQLHelper.CreateSqlParam("@PurchaseId", v);
            }

            public static SqlParameter GetMovDate(object v)
            {
                return SQLHelper.CreateSqlParam("@MovDate", v);
            }

            public static SqlParameter GetStartDate(object v)
            {
                return SQLHelper.CreateSqlParam("@StartDate", v);
            }

            public static SqlParameter GetEndDate(object v)
            {
                return SQLHelper.CreateSqlParam("@EndDate", v);
            }

            public static SqlParameter GetIsActive(object v)
            {
                return SQLHelper.CreateSqlParam("@IsActive", v);
            }

            public static SqlParameter GetParentMovement(object v)
            {
                return SQLHelper.CreateSqlParam("@ParentMovement", v);
            }
        }

        internal static class Purchase
        {
            public const string Insert = "spInsertPurchase";
            public const string Update = "spUpdatePurchase";
            public const string Delete = "spDeletePurchase";
            public const string GetAll = "spGetAllPurchase";
            public const string Search = "spSearchPurchase";

            public static SqlParameter GetPurchaseId(object v)
            {
                return SQLHelper.CreateSqlParam("@PurchaseId", v);
            }

            public static SqlParameter GetItemId(object v)
            {
                return SQLHelper.CreateSqlParam("@ItemId", v);
            }

            public static SqlParameter GetVendorId(object v)
            {
                return SQLHelper.CreateSqlParam("@VendorId", v);
            }

            public static SqlParameter GetPurchaseDate(object v)
            {
                return SQLHelper.CreateSqlParam("@PurchaseDate", v);
            }

            public static SqlParameter GetStartDate(object v)
            {
                return SQLHelper.CreateSqlParam("@StartDate", v);
            }
            public static SqlParameter GetEndDate(object v)
            {
                return SQLHelper.CreateSqlParam("@EndDate", v);
            }

            public static SqlParameter GetPONumber(object v)
            {
                return SQLHelper.CreateSqlParam("@PONumber", v);
            }

            public static SqlParameter GetInvoiceNumber(object v)
            {
                return SQLHelper.CreateSqlParam("@InvoiceNumber", v);
            }

            public static SqlParameter GetDescription(object v)
            {
                return SQLHelper.CreateSqlParam("@Description", v);
            }

            public static SqlParameter GetTagNo(object v)
            {
                return SQLHelper.CreateSqlParam("@TagNo", v);
            }
            
            public static SqlParameter GetTransType(object v)
            {
                return SQLHelper.CreateSqlParam("@TransTypeId", v);
            }

        }
        internal static class Vendor
        {
            public const string Insert = "spInsertVendor";
            public const string Update = "spUpdateVendor";
            public const string Delete = "spDeleteVendor";
            public const string GetAll = "spGetAllVendor";
            public const string Search = "spSearchVendor";

            public static SqlParameter GetVendorId(object v)
            {
                return SQLHelper.CreateSqlParam("@VendorId", v);
            }

            public static SqlParameter GetVendorName(object v)
            {
                return SQLHelper.CreateSqlParam("@VendorName", v);
            }

            public static SqlParameter GetAddress(object v)
            {
                return SQLHelper.CreateSqlParam("@Address", v);
            }

            public static SqlParameter GetContactPerson(object v)
            {
                return SQLHelper.CreateSqlParam("@ContactPerson", v);
            }

            public static SqlParameter GetContact(object v)
            {
                return SQLHelper.CreateSqlParam("@Contact", v);
            }

            public static SqlParameter GetNote(object v)
            {
                return SQLHelper.CreateSqlParam("@Note", v);
            }

        }
        internal static class Location
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

        internal static class Item
        {
            public const string Insert = "spInsertItem";
            public const string Update = "spUpdateItem";
            public const string Delete = "spDeleteItem";
            public const string GetAll = "spGetAllItem";
            public const string Search = "spSearchItem";
            public const string Summary = "spGetStockSummary";

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

        internal static class Department
        {
            public const string Insert = "spInsertDepartment";
            public const string Update = "spUpdateDepartment";
            public const string Delete = "spDeleteDepartment";
            public const string GetAll = "spGetAllDepartment";
            public const string Search = "spSearchDepartment";

            private const string DepartmentId = "@DepartmentId";
            private const string DepartmentName = "@DepartmentName";

            public static SqlParameter GetDeptId(object v)
            {
                return SQLHelper.CreateSqlParam(DepartmentId, v);
            }

            public static SqlParameter GetDeptName(object v)
            {
                return SQLHelper.CreateSqlParam(DepartmentName, v);
            }
        }

        internal static class Person
        {
            public const string Insert = "spInsertPerson";
            public const string Update = "spUpdatePerson";
            public const string Delete = "spDeletePerson";
            public const string GetAll = "spGetAllPerson";
            public const string Search = "spSearchPerson";

            private const string PersonId = "@PersonId";
            private const string DepartmentId = "@DepartmentId";
            private const string Name = "@Name";
            private const string Ext = "@Ext";
            private const string Contact = "@Contact";
            private const string IsActive = "@IsActive";

            public static SqlParameter GetPersonId(object v)
            {
                return SQLHelper.CreateSqlParam(PersonId, v);
            }

            public static SqlParameter GetDpartmentId(object v)
            {
                return SQLHelper.CreateSqlParam(DepartmentId, v);
            }

            public static SqlParameter GetName(object v)
            {
                return SQLHelper.CreateSqlParam(Name, v);
            }

            public static SqlParameter GetExt(object v)
            {
                return SQLHelper.CreateSqlParam(Ext, v);
            }

            public static SqlParameter GetContact(object v)
            {
                return SQLHelper.CreateSqlParam(Contact, v);
            }

            public static SqlParameter GetIsActive(object v)
            {
                return SQLHelper.CreateSqlParam(IsActive, v);
            }
        }
    }
}
