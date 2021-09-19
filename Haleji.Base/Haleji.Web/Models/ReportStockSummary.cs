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
    public class ReportStockSummary
    {
        
        /// <summary>
        /// Store result data
        /// </summary>
        public DataTable Result { get; set; } 

        public string GetName(object row)
        {
            DataRow r = row as DataRow;
            return Convert.ToString(r["ItemName"]);
        }

        public string GetAvailable(object row)
        {
            DataRow r = row as DataRow;
            return Convert.ToString(r["AvailableQty"]);
        }

        public string GetIssued(object row)
        {
            DataRow r = row as DataRow;
            return Convert.ToString(r["IssuedQty"]);
        }

        public string GetOut(object row)
        {
            DataRow r = row as DataRow;
            return Convert.ToString(r["OutQty"]);
        }

        public string GetScrapped(object row)
        {
            DataRow r = row as DataRow;
            return Convert.ToString(r["ScrappedQty"]);
        }

    }
}