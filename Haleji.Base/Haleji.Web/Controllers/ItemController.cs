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
    public class ItemController : Controller
    {
        IRepositoryFactory _factory;

        public ItemController(IRepositoryFactory factory)
        {
            _factory = factory;
        }

        // GET: ItemController
        public ActionResult Index()
        {
            _factory.ItemRepository.Add(new Item()
            {
                ItemId = 1,
                ItemName = "tem 1",
                Description = "no description"
            });

            return View(_factory.ItemRepository.GetAll());
        }

        // GET: ItemController/Create
        public ActionResult Create()
        {
            return PartialView(ViewHelper.CREATE_PARTIAL);
        }

        // POST: ItemController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Item item)
        {
            if (ModelState.IsValid)
            {
                _factory.ItemRepository.Add(item);
                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.CREATE_PARTIAL, item);
            }

        }

        // GET: ItemController/Edit/5
        public ActionResult Edit(int id)
        {
            var found = _factory.ItemRepository.GetById(id);
            if (found != null)
            {
                return PartialView(ViewHelper.EDIT_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: ItemController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Item item)
        {
            if (ModelState.IsValid)
            {
                _factory.ItemRepository.Update(item);
                return RedirectToAction(nameof(Index));
            }
            else
            {
                return BadRequest();
            }
        }

        // GET: ItemController/Delete/5
        public ActionResult Delete(int id)
        {
            var found = _factory.ItemRepository.GetById(id);
            if (found != null)
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: ItemController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Item item)
        {
            _factory.ItemRepository.Remove(item);
            return RedirectToAction(nameof(Index));
        }
    }
}
