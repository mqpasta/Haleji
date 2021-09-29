using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using System;

namespace Haleji.FakeRepository
{
    public class FakeRepositoryFactory : RepositoryFactoryBase, IRepositoryFactory
    {

        public ILocationRepository LocationRepository
        {
            get
            {
                if (_locationRepository == null)
                    _locationRepository = new FakeLocationRepository();

                return _locationRepository;
            }
        }

        public IDepartmentRepository DepartmentRepository
        {
            get
            {
                //if (_departmentRepository == null)
                //    _departmentRepository = new FakeGenericRepository<Department>();

                return _departmentRepository;
            }
        }

        public IItemRepository ItemRepository
        {
            get
            {
                if (_itemRepository == null)
                {
                    _itemRepository = new ItemRepository();
                    _itemRepository.Add(new Item()
                    {
                        ItemId = 1,
                        ItemName = "Blue board",
                        Description = "Whtie descriptino"
                    });
                }
                    

                return _itemRepository;
            }
        }

        public IMovementRepository MovementRepository => throw new System.NotImplementedException();

        public IPersonRepository PersonRepository => throw new System.NotImplementedException();

        public IPurchaseRepository PurchaseRepository => throw new System.NotImplementedException();

        public IStockRepository StockRepository => throw new System.NotImplementedException();

        public IVendorRepository VendorRepository => throw new System.NotImplementedException();

        public IItemDetailsRepository ItemDetailsRepository => throw new System.NotImplementedException();
        public IPurchaseDetailsRepository PurchaseDetailsRepository => throw new System.NotImplementedException();

    }
}
