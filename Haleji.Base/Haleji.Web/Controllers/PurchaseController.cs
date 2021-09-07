using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using Haleji.Web.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Haleji.Web.Controllers
{
    public class PurchaseController : Controller
    {
        private IRepositoryFactory _factory;

        public PurchaseController(IRepositoryFactory factory)
        {
            _factory = factory;
        }

        // GET: PurchaseController
        public ActionResult Index()
        {
            return View();
        }


        // GET: PurchaseController/Create
        public ActionResult Create()
        {
            Purchase p = new Purchase();
            ViewBag.ItemList = ViewHelper.ItemList(_factory);
            ViewBag.VendorList = ViewHelper.VendorList(_factory);
            return View(p);
        }

        // POST: PurchaseController/Create
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

        // GET: PurchaseController/Edit/5
        public ActionResult Edit(int id)
        {
            ViewBag.ItemList = ViewHelper.ItemList(_factory);
            ViewBag.VendorList = ViewHelper.VendorList(_factory);
            return View();
        }

        // POST: PurchaseController/Edit/5
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

        // GET: PurchaseController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: PurchaseController/Delete/5
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
    }
}
