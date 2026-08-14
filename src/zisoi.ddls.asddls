@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item Interface View'
define view entity ZISOI
  as select from zsoi
  association to parent ZISO as _SalesOrder on $projection.SalesOrderID = _SalesOrder.SalesOrderID
{
  key itemid              as ItemID,
  key salesorderid         as SalesOrderID,
      itemno               as ItemNo,
      materialid           as MaterialID,
      quantity             as Quantity,
      unit                 as Unit,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      netprice             as NetPrice,
      currencycode         as CurrencyCode,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat   as LocalLastChangedAt,

      _SalesOrder
}
