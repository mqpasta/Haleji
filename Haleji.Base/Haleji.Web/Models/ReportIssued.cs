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
    public class ReportIssued
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
        
        /// <summary>
        /// Store result data
        /// </summary>
        public List<Movement> Result { get; set; } 
    }
}