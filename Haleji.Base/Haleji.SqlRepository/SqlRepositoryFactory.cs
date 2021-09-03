using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Haleji.BusinessObjects;
using Haleji.RepositoryBase;

namespace Haleji.SqlRepository
{
    public class SqlRepositoryFactory : RepositoryFactoryBase, IRepositoryFactory
    {
        public ILocationRepository LocationRepository
        {
            get
            {
                if (_locationRepository == null)
                    _locationRepository = new SqlLocationRepository();

                return _locationRepository;
            }
        }

        public IDepartmentRepository DepartmentRepository => throw new NotImplementedException();

        public IItemRepository ItemRepository {
            get {
                if (_itemRepository == null)
                    _itemRepository = new SqlItemRepository();

                return _itemRepository;
            }
        }

        public IMovementRepository MovementRepository => throw new NotImplementedException();

        public IPersonRepository PersonRepository => throw new NotImplementedException();

        public IPurchaseRepository PurchaseRepository => throw new NotImplementedException();

        public IStockRepository StockRepository => throw new NotImplementedException();

        public IVendorRepository VendorRepository => throw new NotImplementedException();
    }
}
