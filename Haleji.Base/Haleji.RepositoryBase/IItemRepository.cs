using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Haleji.BusinessObjects;

namespace Haleji.RepositoryBase
{
    public interface IItemRepository : IGenericRepository<Item>
    {
        public DataTable GetStockSummary(); 
    }
}
