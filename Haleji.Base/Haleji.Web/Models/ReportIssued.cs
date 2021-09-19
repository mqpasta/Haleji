using Haleji.BusinessObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace Haleji.Web.Models
{
    /// <summary>
    /// Model for Report to view Issued Items
    /// </summary>
    public class ReportLedger
    {
        [DisplayName("From")]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = false, DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? StartDate { get; set; }
        [DisplayName("To")]
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = false, DataFormatString = "{0:dd/MM/yyyy}")]
        public DateTime? EndDate { get; set; }
        [DisplayName("Person")]
        public long? PersonId { get; set; }
        [DisplayName("Location")]
        public long? LocationId { get; set; }

        [DisplayName("Department")]
        public long? DepartmentId { get; set; }

        [DisplayName("Item")]
        public long? ItemId { get; set; }

        [DisplayName("Transaction Type")]
        public long? TransTypeId { get; set; }

        /// <summary>
        /// Store result data
        /// </summary>
        public DataTable Result { get; set; }

        public string GetMovDate(object o)
        {
            return Convert.ToDateTime((o as DataRow)["MovDate"]).ToShortDateString();
        }

        public string GetTransType(object o)
        {
            return Enum.GetName(typeof(TransactionType), Convert.ToInt64((o as DataRow)["TransTypeId"]));
        }

        public string GetItemName(object o)
        {
            return Convert.ToString((o as DataRow)["ItemName"]) + 
                "(" + Convert.ToString((o as DataRow)["TagNo"]) + ")";
        }

        public string GetName(object o)
        {
            return Convert.ToString((o as DataRow)["Name"]);
        }

        public string GetDepartment(object o)
        {
            return Convert.ToString((o as DataRow)["DepartmentName"]);
        }

        public string GetLocation(object o)
        {
            return Convert.ToString((o as DataRow)["LocationName"]);
        }
    }
}