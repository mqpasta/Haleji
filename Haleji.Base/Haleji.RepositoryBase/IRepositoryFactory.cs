using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Haleji.RepositoryBase
{
    public interface IRepositoryFactory
    {
        ILocationRepository LocationRepository { get; }
        IDepartmentRepository DepartmentRepository { get; }
        IItemRepository ItemRepository { get; }
        IMovementRepository MovementRepository { get; }
        IPersonRepository PersonRepository { get; }
        IPurchaseRepository PurchaseRepository { get; }
        IStockRepository StockRepository { get; }
        IVendorRepository VendorRepository { get; }
    }
}
