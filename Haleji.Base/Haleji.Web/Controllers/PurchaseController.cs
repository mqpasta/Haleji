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
            return View(_factory.PurchaseRepository.GetAll()); ;
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
        public ActionResult Create(Purchase p)
        {
            if (ModelState.IsValid)
            {
                _factory.PurchaseRepository.Add(p);
                return RedirectToAction(nameof(Index));
            }
            else
            {
                SetDropDowns();
                return View(p);
            }
        }

        // GET: PurchaseController/Edit/5
        public ActionResult Edit(int id)
        {
            var found = _factory.PurchaseRepository.GetById(id);
            if (found != null)
            {
                SetDropDowns();
                return View(found);
            }
            else
            {
                return RedirectToAction(nameof(Index));
            }

        }

        private void SetDropDowns()
        {
            ViewBag.ItemList = ViewHelper.ItemList(_factory);
            ViewBag.VendorList = ViewHelper.VendorList(_factory);
        }

        // POST: PurchaseController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Purchase p)
        {
            if (ModelState.IsValid)
            {
                _factory.PurchaseRepository.Update(p);
                return RedirectToAction(nameof(Index));
            }
            else
            {
                SetDropDowns();
                return View(p);
            }
        }

        // GET: PurchaseController/Delete/5
        public ActionResult Delete(int id)
        {
            var found = _factory.PurchaseRepository.GetById(id);
            if (found != null)
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: PurchaseController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Purchase p)
        {
            if (p != null && p.PurchaseId > 0)
            {
                try
                {
                    _factory.PurchaseRepository.Remove(p);
                }
                catch (Exception e)
                {
                    ModelState.AddModelError("Error", e.Message);
                    return PartialView(ViewHelper.DELETE_PARTIAL, p);
                }
                return RedirectToAction(nameof(Index));
            }
            else
            {
                return BadRequest();
            }
        }
    }
}
