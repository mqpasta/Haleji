using Haleji.BusinessObjects;
using Haleji.RepositoryBase;
using Haleji.Web.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Transactions;

namespace Haleji.Web.Controllers
{
    public class TransferController : Controller
    {
        IRepositoryFactory _factory;

        public TransferController(IRepositoryFactory factory)
        {
            _factory = factory;
        }

        // GET: IssueController
        public ActionResult Index()
        {
            return RedirectToAction(nameof(Issued));
        }

        public ActionResult Issued()
        {
            ViewBag.TransferType = "Issued";
            return View(_factory.MovementRepository.GetAllIssue());
        }

        public ActionResult Received()
        {
            ViewBag.TransferType = "Received";
            return View(_factory.MovementRepository.GetlAllReceived());
        }

        public ActionResult Discarded()
        {
            ViewBag.TransferType = "Discarded";
            return View(_factory.MovementRepository.GetAllOutStock());
        }

        public ActionResult Scrapped()
        {
            ViewBag.TransferType = "Scrapped";
            return View(_factory.MovementRepository.GetAllScrap());
        }

        // GET: IssueController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: IssueController/Create
        public ActionResult Create()
        {
            return View(_factory.PurchaseRepository.GetByTransactionType(Convert.ToInt64(TransactionType.Available)));
        }

        // POST: IssueController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Movement m)
        {
            if (ModelState.IsValid)
            {
                if (m.PurchaseId == null)
                    return BadRequest();

                m.IsActive = true;
                var pur = _factory.PurchaseRepository.GetById(m.PurchaseId.Value);
                pur.CurrentTransType = Convert.ToInt64(TransactionType.Issued);

                using (TransactionScope sc = new TransactionScope())
                {
                    _factory.MovementRepository.Add(m);
                    _factory.PurchaseRepository.Update(pur);
                    sc.Complete();
                }

                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }

        // GET: IssueController/Edit/5
        public ActionResult Edit(int id)
        {
            var found = _factory.MovementRepository.GetById(id);
            if (found != null)
            {
                SetDropDowns(personId: found.PersonId, locationId: found.LocationId);
                return PartialView(ViewHelper.EDIT_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: IssueController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Movement m)
        {
            if (ModelState.IsValid)
            {
                var found = _factory.MovementRepository.GetById(m.MovementId);
                m.PurchaseId = found.PurchaseId;
                m.TransactionTypeId = found.TransactionTypeId;
                m.IsActive = found.IsActive;
                m.ParentMovementId = found.ParentMovementId;
                _factory.MovementRepository.Update(m);

                return NoContent();
            }
            else
            {
                return PartialView(ViewHelper.EDIT_PARTIAL, m);
            }
        }

        // GET: IssueController/Delete/5
        public ActionResult Delete(int id)
        {
            var found = _factory.MovementRepository.GetById(id);
            if (found != null)
            {
                return PartialView(ViewHelper.DELETE_PARTIAL, found);
            }
            else
            {
                return BadRequest();
            }
        }

        // POST: IssueController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Movement m)
        {
            var found = _factory.MovementRepository.GetById(m.MovementId);
            if (found != null)
            {
                var t = (TransactionType)found.TransactionTypeId;
                long? purchaseId = null;
                Purchase p = new();
                Movement parent = new();

                switch (t)
                {
                    case TransactionType.Available:
                        break;
                    case TransactionType.Issued:
                        using (TransactionScope sc = new TransactionScope())
                        {
                            // remove issued item
                            purchaseId = found.PurchaseId;
                            _factory.MovementRepository.Remove(found);

                            // update status to available
                            p = _factory.PurchaseRepository.GetById(purchaseId.Value);
                            p.CurrentTransType = (int)TransactionType.Available;
                            _factory.PurchaseRepository.Update(p);

                            // complete transaction
                            sc.Complete();

                            return NoContent();
                        }
                    case TransactionType.Discarded:
                        purchaseId = found.PurchaseId;
                        p = _factory.PurchaseRepository.GetById(purchaseId.Value);

                        // if item is not still in discarded status
                        if (p.CurrentTransType != (int)TransactionType.Discarded)
                        {
                            ModelState.AddModelError(string.Empty,
                                "The item status has been changed.\n We cannot undo this operation.");
                            return PartialView(ViewHelper.DELETE_PARTIAL, m);
                        }

                        using (TransactionScope sc = new TransactionScope())
                        {
                            _factory.MovementRepository.Remove(found);
                            p.CurrentTransType = (int)TransactionType.Available;
                            _factory.PurchaseRepository.Update(p);

                            sc.Complete();

                            return NoContent();
                        }
                    case TransactionType.Received:
                        parent = _factory.MovementRepository.GetById(found.ParentMovementId.Value);
                        purchaseId = found.PurchaseId;
                        p = _factory.PurchaseRepository.GetById(purchaseId.Value);

                        // if already issues to someone else
                        if (p.CurrentTransType != (int)TransactionType.Available)
                        {
                            ModelState.AddModelError(string.Empty,
                                "The item has been issued again.\n We cannot undo this operation.");
                            return PartialView(ViewHelper.DELETE_PARTIAL, m);
                        }

                        using (TransactionScope sc = new TransactionScope())
                        {
                            // remove the line
                            _factory.MovementRepository.Remove(found);
                            // update parent transaction to incmoplete
                            parent.IsActive = true;
                            _factory.MovementRepository.Update(parent);
                            // set status of the item to issued
                            p.CurrentTransType = (int)TransactionType.Issued;
                            _factory.PurchaseRepository.Update(p);

                            sc.Complete();

                            return NoContent();
                        }
                    case TransactionType.Scrapped:
                        parent = _factory.MovementRepository.GetById(found.ParentMovementId.Value);
                        purchaseId = found.PurchaseId;
                        p = _factory.PurchaseRepository.GetById(purchaseId.Value);

                        // if already issues to someone else
                        if (p.CurrentTransType != (int)TransactionType.Scrapped)
                        {
                            ModelState.AddModelError(string.Empty,
                                "The item has been issued again.\n We cannot undo this operation.");
                            return PartialView(ViewHelper.DELETE_PARTIAL, m);
                        }
                        using (TransactionScope sc = new TransactionScope())
                        {
                            // remove the line
                            _factory.MovementRepository.Remove(found);
                            // update parent transaction to incmoplete
                            parent.IsActive = true;
                            _factory.MovementRepository.Update(parent);
                            // set status of the item to issued
                            p.CurrentTransType = (int)TransactionType.Discarded;
                            _factory.PurchaseRepository.Update(p);

                            sc.Complete();

                            return NoContent();
                        }
                }
                return BadRequest();
            }
            else
            {
                return BadRequest();
            }
        }

        public ActionResult TransferItem(long id)
        {

            var found = _factory.PurchaseRepository.GetById(id);
            if (found != null)
            {
                Movement m = SetMovementForUI(found);

                SetDropDowns();
                ViewBag.PartialTitle = "Receive";
                return PartialView(ViewHelper.CREATE_PARTIAL, m);
            }
            else
            {
                return RedirectToAction(nameof(Create));
            }

        }

        public ActionResult DiscardItem(long id)
        {
            var found = _factory.PurchaseRepository.GetById(id);
            if (found != null)
            {
                Movement m = SetMovementForUI(found);
                SetDropDowns();
                return PartialView("_DiscardPartial", m);

            }
            else
            {
                return RedirectToAction(nameof(Create));
            }

        }

        public ActionResult SaveDiscard(Movement m)
        {
            if (m != null && m.PurchaseId != null)
            {
                using (TransactionScope sc = new TransactionScope())
                {
                    Movement nm = new Movement();
                    nm.Update(m);
                    nm.MovDate = m.MovDate;
                    nm.IsActive = true;
                    nm.TransactionTypeId = Convert.ToInt32(TransactionType.Discarded);
                    _factory.MovementRepository.Add(nm);

                    var pur = _factory.PurchaseRepository.GetById(m.PurchaseId.Value);
                    pur.CurrentTransType = Convert.ToInt32(TransactionType.Discarded);
                    _factory.PurchaseRepository.Update(pur);

                    sc.Complete();

                    return NoContent();
                }
            }
            else
                return BadRequest();
        }

        public ActionResult SaveScrap(Movement m)
        {
            var found = _factory.MovementRepository.GetById(m.MovementId);
            if (found != null)
            {
                using (TransactionScope sc = new TransactionScope())
                {
                    Movement nm = new Movement();
                    nm.Update(m);
                    nm.MovDate = m.MovDate;
                    nm.IsActive = false;
                    nm.TransactionTypeId = Convert.ToInt32(TransactionType.Scrapped);
                    nm.ParentMovementId = found.MovementId;
                    _factory.MovementRepository.Add(nm);

                    found.IsActive = false;
                    _factory.MovementRepository.Update(found);

                    var pur = _factory.PurchaseRepository.GetById(m.PurchaseId.Value);
                    pur.CurrentTransType = Convert.ToInt32(TransactionType.Scrapped);
                    _factory.PurchaseRepository.Update(pur);

                    sc.Complete();

                    return NoContent();
                }
            }
            else
                return BadRequest();
        }

        public ActionResult GetReceive(long id)
        {
            var found = _factory.MovementRepository.GetById(id);
            if (found != null)
                return PartialView("_ReceivePartial", found);
            else
                return BadRequest();
        }

        public ActionResult GetScrap(long id)
        {
            var found = _factory.MovementRepository.GetById(id);
            if (found != null)
                return PartialView("_ScrapPartial", found);
            else
                return BadRequest();
        }

        public ActionResult SaveReceive(Movement m)
        {
            var found = _factory.MovementRepository.GetById(m.MovementId);
            if (found != null)
            {
                using (TransactionScope sc = new TransactionScope())
                {
                    // new transaction for receiving
                    Movement nm = new Movement();
                    nm.Update(found);
                    nm.MovementId = 0;
                    nm.MovDate = m.MovDate;
                    nm.ParentMovementId = found.MovementId;
                    nm.IsActive = false;
                    nm.TransactionTypeId = Convert.ToInt32(TransactionType.Received);
                    _factory.MovementRepository.Add(nm);

                    // update current transaction
                    found.IsActive = false;
                    _factory.MovementRepository.Update(found);

                    //update item status
                    var pi = _factory.PurchaseRepository.GetById(found.PurchaseId.Value);
                    pi.CurrentTransType = Convert.ToInt32(TransactionType.Available);
                    _factory.PurchaseRepository.Update(pi);

                    sc.Complete();
                    return NoContent();

                }
            }
            else
                return BadRequest();
        }

        private void SetDropDowns(long? personId = null, long? locationId = null)
        {
            ViewBag.PersonList = ViewHelper.PersonList(_factory, personId);
            ViewBag.LocationList = ViewHelper.LocationList(_factory, locationId);
        }

        private static Movement SetMovementForUI(Purchase found)
        {
            Movement m = new Movement();
            m.MovDate = DateTime.Today;
            m.PurchaseId = found.PurchaseId;
            m.ItemName = found.ItemName + "(" + found.TagNo + ")";
            m.TransactionTypeId = Convert.ToInt64(TransactionType.Issued);
            return m;
        }
    }
}
