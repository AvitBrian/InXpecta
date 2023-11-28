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
import { cn } from "../../lib/utils";
const Table = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("div", { className: "relative w-full overflow-auto" },
    React.createElement("table", Object.assign({ ref: ref, className: cn("w-full caption-bottom text-sm", className) }, props))));
});
Table.displayName = "Table";
const TableHeader = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("thead", Object.assign({ ref: ref, className: cn("[&_tr]:border-b", className) }, props)));
});
TableHeader.displayName = "TableHeader";
const TableBody = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("tbody", Object.assign({ ref: ref, className: cn("[&_tr:last-child]:border-0", className) }, props)));
});
TableBody.displayName = "TableBody";
const TableFooter = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("tfoot", Object.assign({ ref: ref, className: cn("bg-gray-900 font-medium text-gray-50 dark:bg-gray-50 dark:text-gray-900", className) }, props)));
});
TableFooter.displayName = "TableFooter";
const TableRow = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("tr", Object.assign({ ref: ref, className: cn("border-b transition-colors hover:bg-gray-100/50 data-[state=selected]:bg-gray-100 dark:hover:bg-gray-800/50 dark:data-[state=selected]:bg-gray-800", className) }, props)));
});
TableRow.displayName = "TableRow";
const TableHead = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("th", Object.assign({ ref: ref, className: cn("h-12 px-4 text-left align-middle font-medium text-gray-500 [&:has([role=checkbox])]:pr-0 dark:text-gray-400", className) }, props)));
});
TableHead.displayName = "TableHead";
const TableCell = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("td", Object.assign({ ref: ref, className: cn("p-4 align-middle [&:has([role=checkbox])]:pr-0", className) }, props)));
});
TableCell.displayName = "TableCell";
const TableCaption = React.forwardRef((_a, ref) => {
  var { className } = _a, props = __rest(_a, ["className"]);
  return (React.createElement("caption", Object.assign({ ref: ref, className: cn("mt-4 text-sm text-gray-500 dark:text-gray-400", className) }, props)));
});
TableCaption.displayName = "TableCaption";
export { Table, TableHeader, TableBody, TableFooter, TableHead, TableRow, TableCell, TableCaption, };
