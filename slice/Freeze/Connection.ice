//
// Copyright (c) ZeroC, Inc. All rights reserved.
//

#pragma once

#include <Freeze/Transaction.ice>
#include <Ice/Version.ice>
#include <Ice/CommunicatorF.ice>

[["cpp:header-ext:h", "cpp:dll-export:FREEZE_API"]]

module Freeze
{

/**
 *
 * An attempt was made to start a transaction
 * while a previous transaction has not yet been
 * committed or rolled back.
 *
 **/
local exception TransactionAlreadyInProgressException
{
}

/**
 *
 * A connection to a database (database environment with Berkeley
 * DB). If you want to use a connection concurrently
 * in multiple threads, you need to serialize access to this
 * connection.
 *
 **/
local interface Connection
{
    /**
     *
     * Create a new transaction. Only one transaction at a time can
     * be associated with a connection.
     *
     * @return The new transaction.
     *
     * @throws TransactionAlreadyInProgressException Raised if a
     * transaction is already associated with this connection.
     *
     **/
    Transaction beginTransaction();

    /**
     *
     * Returns the transaction associated with this connection.
     *
     * @return The current transaction if there is one, null otherwise.
     *
     **/
    ["cpp:const"] Transaction currentTransaction();

    /**
     *
     * Remove an unused Freeze Map index.
     *
     * @param mapName The name of the Freeze map.
     *
     * @param indexName The name of the index.
     *
     * @throws IndexNotFoundException Raised if this index
     * does not exist.
     *
     **/
    void removeMapIndex(string mapName, string indexName);

    /**
     *
     * Closes this connection. If there is an associated transaction,
     * it is rolled back.
     *
     **/
    void close();

    /**
     *
     * Returns the communicator associated with this connection.
     *
     * @return The communicator.
     *
     **/
    ["cpp:const"] Ice::Communicator getCommunicator();

    /**
     *
     * Returns the encoding version used to encode the data.
     *
     * @return The encoding version.
     *
     **/
    ["cpp:const"] Ice::EncodingVersion getEncoding();

    /**
     *
     * The name of the connected system (for example, the Berkeley DB
     * environment).
     *
     * @return The name of the connected system.
     *
     **/
    ["cpp:const"] string getName();
}

}
