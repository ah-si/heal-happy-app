# heal_happy_sdk.model.UserEvent

## Load the model package
```dart
import 'package:heal_happy_sdk/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**patientToken** | **String** |  | [optional] 
**patient** | [**MinimalUser**](MinimalUser.md) |  | 
**healer** | [**Healer**](Healer.md) |  | 
**room** | [**OfficeRoom**](OfficeRoom.md) |  | [optional] 
**office** | [**Office**](Office.md) |  | [optional] 
**isUrgent** | **bool** |  | 
**isHealerPresent** | **bool** |  | 
**isPatientPresent** | **bool** |  | 
**isCancelled** | **bool** |  | 
**type** | [**HealerEventType**](HealerEventType.md) |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**start** | [**DateTime**](DateTime.md) |  | 
**end** | [**DateTime**](DateTime.md) |  | 
**name** | **String** |  | 
**description** | **String** |  | [optional] 
**cancelledDescription** | **String** |  | [optional] 
**link** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


