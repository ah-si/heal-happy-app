# heal_happy_sdk.api.UserApi

## Load the API package
```dart
import 'package:heal_happy_sdk/api.dart';
```

All URIs are relative to *https://localhost:3443*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createEvent**](UserApi.md#createevent) | **POST** /api/v1/healers/{id}/events | 
[**deleteEvent**](UserApi.md#deleteevent) | **DELETE** /api/v1/users/me/events/{eventId} | 
[**getEvents**](UserApi.md#getevents) | **GET** /api/v1/users/me/events | 
[**getHealerAvailabilities**](UserApi.md#gethealeravailabilities) | **GET** /api/v1/healers/{id}/availabilities | 
[**getHealerProfile**](UserApi.md#gethealerprofile) | **GET** /api/v1/healers/{id} | 
[**getProfile**](UserApi.md#getprofile) | **GET** /api/v1/users/me | 
[**getSpecialities**](UserApi.md#getspecialities) | **GET** /api/v1/healers/specialities | 
[**getUser**](UserApi.md#getuser) | **GET** /api/v1/users/{id} | 
[**putAvatar**](UserApi.md#putavatar) | **PUT** /api/v1/users/me/avatar | 
[**putDiploma**](UserApi.md#putdiploma) | **PUT** /api/v1/users/me/diploma | 
[**putTerms**](UserApi.md#putterms) | **PUT** /api/v1/users/me/terms | 
[**resendActivationLink**](UserApi.md#resendactivationlink) | **GET** /api/v1/users/me/resendActivationLink | 
[**saveProfile**](UserApi.md#saveprofile) | **PUT** /api/v1/users/me | 
[**saveUser**](UserApi.md#saveuser) | **PUT** /api/v1/users/{id} | 
[**searchHealers**](UserApi.md#searchhealers) | **GET** /api/v1/healers/search | 


# **createEvent**
> createEvent(id, createEventRequest)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final String id = id_example; // String | 
final CreateEventRequest createEventRequest = ; // CreateEventRequest | 

try { 
    api.createEvent(id, createEventRequest);
} catch on DioError (e) {
    print('Exception when calling UserApi->createEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **createEventRequest** | [**CreateEventRequest**](CreateEventRequest.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteEvent**
> deleteEvent(eventId)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final String eventId = eventId_example; // String | 

try { 
    api.deleteEvent(eventId);
} catch on DioError (e) {
    print('Exception when calling UserApi->deleteEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **eventId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getEvents**
> BuiltList<UserEvent> getEvents()



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();

try { 
    final response = api.getEvents();
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getEvents: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;UserEvent&gt;**](UserEvent.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHealerAvailabilities**
> HealerAvailabilities getHealerAvailabilities(id, from)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final String id = id_example; // String | 
final String from = from_example; // String | 

try { 
    final response = api.getHealerAvailabilities(id, from);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getHealerAvailabilities: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **from** | **String**|  | 

### Return type

[**HealerAvailabilities**](HealerAvailabilities.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getHealerProfile**
> Healer getHealerProfile(id)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final String id = id_example; // String | 

try { 
    final response = api.getHealerProfile(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getHealerProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Healer**](Healer.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProfile**
> User getProfile()



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();

try { 
    final response = api.getProfile();
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getProfile: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSpecialities**
> BuiltMap<String, String> getSpecialities(onlyExisting)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';

final api = HealHappySdk().getUserApi();
final bool onlyExisting = true; // bool | 

try { 
    final response = api.getSpecialities(onlyExisting);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getSpecialities: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **onlyExisting** | **bool**|  | [optional] 

### Return type

**BuiltMap&lt;String, String&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUser**
> User getUser(id)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final String id = id_example; // String | 

try { 
    final response = api.getUser(id);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->getUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**User**](User.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putAvatar**
> FileData putAvatar(avatar)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final MultipartFile avatar = BINARY_DATA_HERE; // MultipartFile | 

try { 
    final response = api.putAvatar(avatar);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->putAvatar: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **avatar** | **MultipartFile**|  | [optional] 

### Return type

[**FileData**](FileData.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putDiploma**
> FileData putDiploma(diploma)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final MultipartFile diploma = BINARY_DATA_HERE; // MultipartFile | 

try { 
    final response = api.putDiploma(diploma);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->putDiploma: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **diploma** | **MultipartFile**|  | [optional] 

### Return type

[**FileData**](FileData.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **putTerms**
> FileData putTerms(terms)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final MultipartFile terms = BINARY_DATA_HERE; // MultipartFile | 

try { 
    final response = api.putTerms(terms);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->putTerms: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **terms** | **MultipartFile**|  | [optional] 

### Return type

[**FileData**](FileData.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resendActivationLink**
> resendActivationLink()



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();

try { 
    api.resendActivationLink();
} catch on DioError (e) {
    print('Exception when calling UserApi->resendActivationLink: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **saveProfile**
> User saveProfile(user)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final User user = ; // User | 

try { 
    final response = api.saveProfile(user);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->saveProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | [**User**](User.md)|  | [optional] 

### Return type

[**User**](User.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **saveUser**
> User saveUser(id, user)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final String id = id_example; // String | 
final User user = ; // User | 

try { 
    final response = api.saveUser(id, user);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->saveUser: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **user** | [**User**](User.md)|  | [optional] 

### Return type

[**User**](User.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchHealers**
> PaginatedHealers searchHealers(job, localization, page)



### Example 
```dart
import 'package:heal_happy_sdk/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api = HealHappySdk().getUserApi();
final String job = job_example; // String | 
final String localization = localization_example; // String | 
final int page = 56; // int | 

try { 
    final response = api.searchHealers(job, localization, page);
    print(response);
} catch on DioError (e) {
    print('Exception when calling UserApi->searchHealers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **job** | **String**|  | 
 **localization** | **String**|  | 
 **page** | **int**|  | 

### Return type

[**PaginatedHealers**](PaginatedHealers.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

