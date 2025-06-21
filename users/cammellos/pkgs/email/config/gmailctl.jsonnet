// Uncomment if you want to use the standard library.
// local lib = import 'gmailctl.libsonnet';
local food_label = "food";
local paypal_label = "paypal";
local linkedin_label = "linkedin";
local amazon_label = "amazon";
local ebay_label = "ebay";
local flights_label = "flights";
local canaan_lane_label = "canaan lane";
local to_act_on_label = "to-act-on";

{
  version: "v1alpha3",
  author: {
    name: "YOUR NAME HERE (auto imported)",
    email: "your-email@gmail.com"
  },
  labels: [
    {
      name: canaan_lane_label
    },
    {
      name: to_act_on_label,
    },
    {
      name: "audience club"
    },
    {
      name: flights_label,
    },
    {
      name: ebay_label
    },
    {
      name: "[Imap]/Drafts"
    },
    {
      name: "[Imap]/Sent"
    },
    {
      name: "[Imap]/Trash"
    },
    {
      name: "calendar"
    },
    {
      name: linkedin_label
    },
    {
      name: "public-integrity"
    },
    {
      name: paypal_label,
    },
    {
      name: "facebook"
    },
    {
      name: "github"
    },
    {
      name: amazon_label
    },
    {
      name: "dropbox"
    },
    {
      name: "ghost-club"
    },
    {
      name: "songkick"
    },
    {
      name: food_label
    }
  ],
  rules: [
    {
      filter: {
	or: [
	{from: "paypal.it"},
	{from: "paypal.co.uk"},
	{from: "paypal.com"},
	],
      },
      actions: {
	archive: true,
	markRead: true,
	labels: [paypal_label],
      },
    },
    {
      filter: {
	or: [
	{from: "just-eat.it"},
	{from: "just-eat.co.uk"},
	],
      },
      actions: {
	archive: true,
	markRead: true,
	labels: [food_label],
      },
    },
    {
      filter: {
	or: [
	{from: "linkedin.com"},
	],
      },
      actions: {
	archive: true,
	labels: [linkedin_label],
      },
    },
    {
      filter: {
	or: [
	{from: "amazon.com"},
	{from: "amazon.co.uk"},
	{from: "amazon.it"},
	],
      },
      actions: {
	markRead: true,
	archive: true,
	labels: [amazon_label],
      },
    },
{
      filter: {
	or: [
	{from: "ebay.com"},
	{from: "ebay.co.uk"},
	{from: "ebay.it"},
	],
      },
      actions: {
	markRead: true,
	archive: true,
	labels: [ebay_label],
      },
    },
{
      filter: {
	or: [
	{from: "ryanair.com"},
	{from: "ryanair.co.uk"},
	{from: "ryanair.it"},
	{from: "easyjet.com"},
	{from: "easyjet.co.uk"},
	{from: "easyjet.it"},
	],
      },
      actions: {
	archive: true,
	labels: [flights_label],
      },
    }
{
      filter: {
	or: [
	{from: "canaanlane.edin.sch.uk"},
	],
      },
      actions: {
	labels: [canaan_lane_label],
      },
    }
  ],
}
