"use client";
var __rest = (this && this.__rest) || function (s, e) {
  var t = {};
  for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
    t[p] = s[p];
  if (s != null && typeof Object.getOwnPropertySymbols === "function")
    for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
      if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
        t[p[i]] = s[p[i]];
    }
  return t;
};
import * as React from "react";
import * as TabsPrimitive from "@radix-ui/react-tabs";
import { cn } from "../../lib/utils";
const Tabs = TabsPrimitive.Root;
const TabsList = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement(TabsPrimitive.List, Object.assign({ ref: ref, className: cn("inline-flex h-10 items-center justify-center rounded-md bg-gray-100 p-1 text-gray-500  dark:bg-gray-800 dark:text-gray-400 ", className) }, props)));
});
TabsList.displayName = TabsPrimitive.List.displayName;
const TabsTrigger = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement(TabsPrimitive.Trigger, Object.assign({ ref: ref, className: cn("inline-flex items-center justify-center whitespace-nowrap active:bg-red-500 rounded-lg px-3 py-1.5 text-xl m-3 font-medium  transition-all outline-none focus-visible:outline-none  focus-visible:ring-gray-200  disabled:pointer-events-none disabled:opacity-50 data-[state=active]:bg-black/20 data-[state=active]:text-gray-950 data-[state=active]:shadow-sm  dark: dark:data-[state=active]:bg-gray-950 dark:data-[state=active]: ", className) }, props)));
});
TabsTrigger.displayName = TabsPrimitive.Trigger.displayName;
const TabsContent = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement(TabsPrimitive.Content, Object.assign({ ref: ref, className: cn("mt-2 focus-visible:outline-none focus-visible:ring-offset-2 dark:ring-offset-gray-950 dark:focus-visible:ring-gray-300 ", className) }, props)));
});
TabsContent.displayName = TabsPrimitive.Content.displayName;
export { Tabs, TabsList, TabsTrigger, TabsContent };
