using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using Haleji.Web.Models;
using Irada.Common.DAL;
using Haleji.SqlRepository;
using System.Data.SqlClient;


namespace Haleji.Web.Controllers
{
    public class PurchaseDetailsController : Controller
    {
        IRepositoryFactory _factory;

        public PurchaseDetailsController(IRepositoryFactory factory)
        {
            _factory = factory;
        }
        // GET: PurchaseDetailsController
        public ActionResult Index()
        {
            return View(_factory.PurchaseDetailsRepository.GetAll());
        }

        // GET: PurchaseDetailsController/Details/5
        public ActionResult Details(int id)
        {
            var found = _factory.PurchaseDetailsRepository.GetByPurchaseId(id);
            if (found != null)
            {
                return View("Details",found);
            }
            else
            {
                return RedirectToAction(nameof(Index));
            }

        }

       

        // GET: PurchaseDetailsController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: PurchaseDetailsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: PurchaseDetailsController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: PurchaseDetailsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: PurchaseDetailsController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: PurchaseDetailsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        /*[HttpPost]
        public ActionResult SaveDetails(FormCollection collection)
        {
            foreach (var key in collection)
            {
                x[x.Key] = x.Value;
            }
        }*/


    }
}
