@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Projection View'
@Metadata.allowExtensions: true
@UI.headerInfo: { typeName: 'Sales Order', typeNamePlural: 'Sales Orders' }
@Search.searchable: true
define root view entity ZCSO
  provider contract transactional_query
  as projection on ZISO
{
      @UI.facet: [ 
        { id:              'SalesOrder',
          purpose:         #STANDARD,
          type:            #IDENTIFICATION_REFERENCE,
          label:           'General Information',
          position:        10 },
        { id:              'Item',
          purpose:         #STANDARD,
          type:            #LINEITEM_REFERENCE,
          label:           'Items',
          position:        20,
          targetElement:   '_Item' } 
      ]
  key SalesOrderID,

      @UI.lineItem: [{ position: 10, importance: #HIGH }]
      @UI.identification: [{ position: 10 }]
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Sales Order Number'
      SalesOrderNo,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @EndUserText.label: 'Customer ID'
      CustomerID,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      @EndUserText.label: 'Order Date'
      OrderDate,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @EndUserText.label: 'Net Amount'
      NetAmount,
      
      @EndUserText.label: 'Currency'
      CurrencyCode,

      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 50 }]
      @EndUserText.label: 'Status'
      Status,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      /* associations */
      _Item : redirected to composition child ZCSOI
}
