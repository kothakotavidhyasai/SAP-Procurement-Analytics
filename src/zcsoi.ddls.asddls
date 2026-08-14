@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item Projection'
@UI.headerInfo: { typeName: 'Item', typeNamePlural: 'Items' }
define view entity ZCSOI
  as projection on ZISOI
{
      @UI.facet: [{ purpose: #STANDARD, type: #IDENTIFICATION_REFERENCE, label: 'Item Details', position: 10 }]
  key ItemID,
  key SalesOrderID,

      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
      @EndUserText.label: 'Item Number'
      ItemNo,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @EndUserText.label: 'Material ID'
      MaterialID,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      @EndUserText.label: 'Quantity'
      Quantity,
      
      @EndUserText.label: 'Unit'
      Unit,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @EndUserText.label: 'Net Price'
      NetPrice,
      
      @EndUserText.label: 'Currency'
      CurrencyCode,

      LocalLastChangedAt,

      _SalesOrder : redirected to parent ZCSO
}
