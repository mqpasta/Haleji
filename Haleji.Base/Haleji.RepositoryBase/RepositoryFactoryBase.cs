using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Haleji.RepositoryBase
{
    public abstract class RepositoryFactoryBase
    {
        protected ILocationRepository _locationRepository;
        protected IDepartmentRepository _departmentRepository;
        protected IItemRepository _itemRepository;
        protected IMovementRepository _movementRepository;
        protected IPersonRepository _personRepository;
        protected IPurchaseRepository _purchaseRepository;
        protected IStockRepository _stockRepository;
        protected IVendorRepository _vendorRepository;
    }
}
