using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace Haleji.BusinessObjects
{
    public class Item : IEntity
    {
        [DisplayName("Item ID")]
        [Key]
        public long ItemId { get; set; }
        
        [DisplayName("Item Name")]
        [MaxLength(50, ErrorMessage ="Maximum limit is 50 characters.")]
        [Required]
        public string ItemName { get; set; }
        
        [DisplayName("Item Description")]
        [MaxLength(1000, ErrorMessage ="Maximum limit is 1000 characters.")]
        public string Description { get; set; }

        public long Key
        {
            get { return this.ItemId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(Item), entity, this);

        }
    }
}
