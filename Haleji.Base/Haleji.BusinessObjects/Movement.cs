using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class Movement : IEntity
    {
        [DisplayName("Movement ID")]
        [Key]
        public long MovementId { get; set; }

        [DisplayName("Transaction Type")]
        [Required]
        public TransType TransactionType { get; set; }

        [DisplayName("Person")]
        public Person Person { get; set; }

        [DisplayName("Location")]
        public Location Location { get; set; }

        [DisplayName("Purchase Order")]
        public Purchase Purchase { get; set; }

        [DisplayName("Movement Date")]
        [Required]
        public DateTime MovDate { get; set; }

        [DisplayName("Active")]
        [Required]
        public bool IsActive { get; set; }
        public Movement ParentMovement { get; set; }

        public long Key
        {
            get { return this.MovementId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Movement), entity, this);
        }
    }
}
