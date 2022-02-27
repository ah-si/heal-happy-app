# heal_happy_sdk.api.OfficesApi

## Load the API package
```dart
import 'package:heal_happy_sdk/api.dart';
```

All URIs are relative to *https://soignez-heureux.com*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addHealerToRoom**](OfficesApi.md#addhealertoroom) | **POST** /api/v1/offices/rooms/{id}/healers | 
[**addManager**](OfficesApi.md#addmanager) | **POST** /api/v1/offices/{id}/managers | 
[**addRoom**](OfficesApi.md#addroom) | **POST** /api/v1/offices/{id}/rooms | 
[**createOffice**](OfficesApi.md#createoffice) | **POST** /api/v1/offices | 
[**deleteRoom**](OfficesApi.md#deleteroom) | **DELETE** /api/v1/offices/rooms/{id} | 
[**getOffice**](OfficesApi.md#getoffice) | **GET** /api/v1/offices/{id} | 
[**getOffices**](OfficesApi.md#getoffices) | **GET** /api/v1/offices | 
[**removeHealerFromRoom**](OfficesApi.md#removehealerfromroom) | **DELETE** /api/v1/offices/rooms/{id}/healers/{healerId} | 
[**removeManager**](OfficesApi.md#removemanager) | **DELETE** /api/v1/offices/{id}/managers/{managerId} | 
[**updateOffice**](OfficesApi.md#updateoffice) | **PUT** /api/v1/offices/{id} | 
[**updateRoom**](OfficesApi.md#updateroom) | **PUT** /api/v1/offices/rooms/{id} | 


# **addHealerToRoom**
> addHealerToRoom(id, userEmail)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 
final UserEmail userEmail = ; // UserEmail | 

try { 
    api.addHealerToRoom(id, userEmail);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->addHealerToRoom: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userEmail** | [**UserEmail**](UserEmail.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addManager**
> addManager(id, userEmail)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 
final UserEmail userEmail = ; // UserEmail | 

try { 
    api.addManager(id, userEmail);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->addManager: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **userEmail** | [**UserEmail**](UserEmail.md)|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **addRoom**
> OfficeRoom addRoom(id, officeRoom)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 
final OfficeRoom officeRoom = ; // OfficeRoom | 

try { 
    final response = api.addRoom(id, officeRoom);
    print(response);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->addRoom: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **officeRoom** | [**OfficeRoom**](OfficeRoom.md)|  | 

### Return type

[**OfficeRoom**](OfficeRoom.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createOffice**
> OfficeInfo createOffice(officeInfo)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final OfficeInfo officeInfo = ; // OfficeInfo | 

try { 
    final response = api.createOffice(officeInfo);
    print(response);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->createOffice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **officeInfo** | [**OfficeInfo**](OfficeInfo.md)|  | 

### Return type

[**OfficeInfo**](OfficeInfo.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteRoom**
> deleteRoom(id)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 

try { 
    api.deleteRoom(id);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->deleteRoom: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOffice**
> Office getOffice(id)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 

try { 
    final response = api.getOffice(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->getOffice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Office**](Office.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOffices**
> PaginatedOffices getOffices()



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();

try { 
    final response = api.getOffices();
    print(response);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->getOffices: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PaginatedOffices**](PaginatedOffices.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeHealerFromRoom**
> removeHealerFromRoom(id, healerId)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 
final String healerId = healerId_example; // String | 

try { 
    api.removeHealerFromRoom(id, healerId);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->removeHealerFromRoom: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **healerId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeManager**
> removeManager(id, managerId)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 
final String managerId = managerId_example; // String | 

try { 
    api.removeManager(id, managerId);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->removeManager: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **managerId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOffice**
> OfficeInfo updateOffice(id, officeInfo)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 
final OfficeInfo officeInfo = ; // OfficeInfo | 

try { 
    final response = api.updateOffice(id, officeInfo);
    print(response);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->updateOffice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **officeInfo** | [**OfficeInfo**](OfficeInfo.md)|  | 

### Return type

[**OfficeInfo**](OfficeInfo.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateRoom**
> OfficeRoom updateRoom(id, officeRoom)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getOfficesApi();
final String id = id_example; // String | 
final OfficeRoom officeRoom = ; // OfficeRoom | 

try { 
    final response = api.updateRoom(id, officeRoom);
    print(response);
} catch on DioError (e) {
    print('Exception when calling OfficesApi->updateRoom: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **officeRoom** | [**OfficeRoom**](OfficeRoom.md)|  | 

### Return type

[**OfficeRoom**](OfficeRoom.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

