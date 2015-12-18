/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 *
 * Code generated by Microsoft (R) AutoRest Code Generator 0.14.0.0
 * Changes may cause incorrect behavior and will be lost if the code is
 * regenerated.
 */

package fixtures.http;

import com.microsoft.rest.ServiceCallback;
import com.microsoft.rest.ServiceResponse;
import com.squareup.okhttp.ResponseBody;
import fixtures.http.models.ErrorException;
import java.io.IOException;
import retrofit.Call;
import retrofit.http.GET;

/**
 * An instance of this class provides access to all the operations defined
 * in HttpFailure.
 */
public interface HttpFailure {
    /**
     * The interface defining all the services for HttpFailure to be
     * used by Retrofit to perform actually REST calls.
     */
    interface HttpFailureService {
        @GET("/http/failure/emptybody/error")
        Call<ResponseBody> getEmptyError();

    }
    /**
     * Get empty error form server.
     *
     * @throws ErrorException exception thrown from REST call
     * @throws IOException exception thrown from serialization/deserialization
     * @return the Boolean object wrapped in {@link ServiceResponse} if successful.
     */
    ServiceResponse<Boolean> getEmptyError() throws ErrorException, IOException;

    /**
     * Get empty error form server.
     *
     * @param serviceCallback the async ServiceCallback to handle successful and failed responses.
     * @return the {@link Call} object
     */
    Call<ResponseBody> getEmptyErrorAsync(final ServiceCallback<Boolean> serviceCallback);

}