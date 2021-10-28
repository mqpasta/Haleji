using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Haleji.BusinessObjects;

namespace Haleji.RepositoryBase
{
    public interface IPurchaseDetailsRepository : IGenericRepository<PurchaseDetails>
    {
        List<PurchaseDetails> GetByPurchaseId(long id);

        public void Update(List<PurchaseDetails> purchaseDetails);

        public List<PurchaseDetails> GetAllPurchaseDetails(long id);



    }
    
}
