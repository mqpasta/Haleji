using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class TransType : IEntity
    {
        [DisplayName("Transaction Type ID")]
        [Key]
        public long TransTypeId { get; set; }

        [DisplayName("Transaction Type Name")]
        [Required]
        public string TransTypeName { get; set; }

        public long Key
        {
            get { return this.TransTypeId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Item), entity, this);
        }
    }
}
