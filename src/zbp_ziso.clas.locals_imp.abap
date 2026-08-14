CLASS lhc_SalesOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR SalesOrder RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR SalesOrder~setInitialStatus.

    METHODS calculateNetAmount FOR DETERMINE ON SAVE
      IMPORTING keys FOR SalesOrder~calculateNetAmount.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR SalesOrder~validateCustomer.

    METHODS validateQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR SalesOrder~validateQuantity.

ENDCLASS.

CLASS lhc_SalesOrder IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setInitialStatus.

    MODIFY ENTITIES OF ziso IN LOCAL MODE
      ENTITY SalesOrder
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR key IN keys ( %tky   = key-%tky
                                         Status = 'N' ) ).

  ENDMETHOD.

  METHOD calculateNetAmount.

    READ ENTITIES OF ZISO IN LOCAL MODE
      ENTITY SalesOrder
        FIELDS ( NetAmount )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_salesorder_current).

    READ ENTITIES OF ZISO IN LOCAL MODE
      ENTITY SalesOrder BY \_Item
        FIELDS ( NetPrice Quantity )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items)
      LINK DATA(lt_links).

    DATA lt_amount TYPE TABLE FOR UPDATE ZISO.

    LOOP AT keys INTO DATA(ls_key).

      DATA(lv_total) = VALUE zsoh-netamount( ).

      LOOP AT lt_links INTO DATA(ls_link) WHERE source-%tky = ls_key-%tky.
        READ TABLE lt_items INTO DATA(ls_item)
          WITH KEY %tky = ls_link-target-%tky.
        IF sy-subrc = 0.
          lv_total += ls_item-NetPrice * ls_item-Quantity.
        ENDIF.
      ENDLOOP.

      READ TABLE lt_salesorder_current INTO DATA(ls_current)
        WITH KEY %tky = ls_key-%tky.

      " Only update if the value actually changed - prevents endless save loop
      IF sy-subrc = 0 AND ls_current-NetAmount <> lv_total.
        APPEND VALUE #( %tky      = ls_key-%tky
                         NetAmount = lv_total ) TO lt_amount.
      ENDIF.

    ENDLOOP.

    IF lt_amount IS NOT INITIAL.
      MODIFY ENTITIES OF ZISO IN LOCAL MODE
        ENTITY SalesOrder
          UPDATE FIELDS ( NetAmount )
          WITH lt_amount.
    ENDIF.

  ENDMETHOD.

  METHOD validateCustomer.

    READ ENTITIES OF ziso IN LOCAL MODE
      ENTITY SalesOrder
        FIELDS ( CustomerID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_salesorder).

    LOOP AT lt_salesorder INTO DATA(ls_salesorder).

      IF ls_salesorder-CustomerID IS INITIAL.

        APPEND VALUE #( %tky = ls_salesorder-%tky )
          TO failed-salesorder.

        APPEND VALUE #( %tky                 = ls_salesorder-%tky
                         %msg                 = new_message( id       = '00'
                                                              number   = '001'
                                                              severity = if_abap_behv_message=>severity-error
                                                              v1       = 'Customer ID is mandatory' )
                         %element-CustomerID  = abap_true )
          TO reported-salesorder.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.
  METHOD validateQuantity.

    READ ENTITIES OF ziso IN LOCAL MODE
      ENTITY SalesOrder
        FIELDS ( NetAmount )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_salesorder).

    LOOP AT lt_salesorder INTO DATA(ls_salesorder).

      IF ls_salesorder-NetAmount <= 0.

        APPEND VALUE #( %tky = ls_salesorder-%tky )
          TO failed-salesorder.

        APPEND VALUE #( %tky                = ls_salesorder-%tky
                         %msg                = new_message( id       = '00'
                                                              number   = '001'
                                                              severity = if_abap_behv_message=>severity-error
                                                              v1       = 'Net Amount must be greater than zero' )
                         %element-NetAmount  = abap_true )
          TO reported-salesorder.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_Item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateItemQuantity FOR VALIDATE ON SAVE
      IMPORTING keys FOR Item~validateItemQuantity.

ENDCLASS.

CLASS lhc_Item IMPLEMENTATION.

  METHOD validateItemQuantity.

    READ ENTITIES OF ziso IN LOCAL MODE
      ENTITY Item
        FIELDS ( Quantity )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_item).

    LOOP AT lt_item INTO DATA(ls_item).

      IF ls_item-Quantity <= 0.

        APPEND VALUE #( %tky = ls_item-%tky )
          TO failed-item.

        APPEND VALUE #( %tky               = ls_item-%tky
                         %msg               = new_message( id       = '00'
                                                             number   = '001'
                                                             severity = if_abap_behv_message=>severity-error
                                                             v1       = 'Quantity must be greater than zero' )
                         %element-Quantity  = abap_true )
          TO reported-item.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

