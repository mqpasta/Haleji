using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Haleji.BusinessObjects
{
    public class ItemDetails : IEntity
    {
        [DisplayName("Item Details Id")]
        [Key]
        public long ItemDetailsId { get; set; }

        [DisplayName("Item Id")]
        [Required]
        public long ItemId { get; set; }

        [DisplayName("Specifications")]
        [Required]
        public string Specifications { get; set; }

        public long Key
        {
            get { return this.ItemDetailsId; }
        }

        public void Update(IEntity entity)
        {
            Helper.Update(typeof(ItemDetails), entity, this);
        }

    }

}
