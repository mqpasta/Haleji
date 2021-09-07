using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Haleji.BusinessObjects;

namespace Haleji.RepositoryBase
{
    public interface IMovementRepository : IGenericRepository<Movement>
    {
        List<Movement> GetAllIssue();

        List<Movement> GetAllInStock();

        List<Movement> GetAllScrap();

        List<Movement> GetAllOutStock();

    }
}
