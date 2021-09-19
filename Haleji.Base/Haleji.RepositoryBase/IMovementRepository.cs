using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Haleji.BusinessObjects;

namespace Haleji.RepositoryBase
{
    public interface IMovementRepository : IGenericRepository<Movement>
    {
        List<Movement> GetAllIssue(bool isActive = true);

        List<Movement> GetlAllReceived();

        List<Movement> GetAllInStock();

        List<Movement> GetAllScrap();

        List<Movement> GetAllOutStock();

        List<Movement> SearchMovement(Movement m, DateTime? sartDate, DateTime? endDate);

        public DataTable SearchLedger(DateTime? startDate, DateTime? endDate,
                                            long? personId, long? departmentId, long? itemId, long? locationId,
                                            long? transTypeId, long? purchaseId);
    }
}
