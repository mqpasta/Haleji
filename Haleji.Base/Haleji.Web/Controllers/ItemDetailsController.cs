using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Haleji.RepositoryBase;
using Haleji.BusinessObjects;
using Haleji.Web.Models;

namespace Haleji.Web.Controllers
{
    public class ItemDetailsController : Controller
    {
        IRepositoryFactory _factory;

        public ItemDetailsController(IRepositoryFactory factory)
        {
            _factory = factory;
        }

        // GET: ItemDetailsController
        public ActionResult Index()
        {
            return View(_factory.ItemDetailsRepository.GetAll());
        }

        // GET: ItemDetailsController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: ItemDetailsController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: ItemDetailsController/Create
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

        // GET: ItemDetailsController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: ItemDetailsController/Edit/5
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

        // GET: ItemDetailsController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: ItemDetailsController/Delete/5
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
