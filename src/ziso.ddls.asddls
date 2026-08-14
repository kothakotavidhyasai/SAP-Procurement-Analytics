@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Interface View'
@Metadata.allowExtensions: true
define root view entity ZISO
  as select from zsoh
  composition [0..*] of ZISOI as _Item
{
  key salesorderid   as SalesOrderID,
      salesorderno   as SalesOrderNo,
      customerid     as CustomerID,
      orderdate      as OrderDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      netamount      as NetAmount,
      currencycode   as CurrencyCode,
      status         as Status,
      @Semantics.user.createdBy: true
      createdby      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      createdat      as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      lastchangedby  as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat  as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat as LocalLastChangedAt,

      _Item
}
