﻿using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using OscarsGame.Web.Identity;
using System;
using System.Web;

namespace OscarsGame.Account
{
    public partial class VerifyPhoneNumber : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var phonenumber = Request.QueryString["PhoneNumber"];
            var code = manager.GenerateChangePhoneNumberToken(User.Identity.GetUserId().ToGuid(), phonenumber);
            PhoneNumber.Value = phonenumber;
        }

        protected void Code_Click(object sender, EventArgs e)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError("", "Invalid code");
                return;
            }

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();

            var result = manager.ChangePhoneNumber(User.Identity.GetUserId().ToGuid(), PhoneNumber.Value, Code.Text);

            if (result.Succeeded)
            {
                var user = manager.FindById(User.Identity.GetUserId().ToGuid());

                if (user != null)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    Response.Redirect("/Account/Manage?m=AddPhoneNumberSuccess");
                }
            }

            // If we got this far, something failed, redisplay form
            ModelState.AddModelError("", "Failed to verify phone");
        }
    }
}