ContiguousBlockAllocator

A more robust replacement for the default server block allocator, PowerOfTwoAllocator. May be used in the Server class to allocate audio/control bus numbers and buffer numbers.

To configure a server to use ContiguousBlockAllocator, execute the following:

aServer.options.blockAllocClass = ContiguousBlockAllocator;

Normally you will not need to address the allocators directly. However, ContiguousBlockAllocator adds one feature not present in PowerOfTwoAllocator, namely the reserve method.

*new(size, pos = 0)

Create a new allocator with size slots. You may block off the first pos slots (the server's audioBusAllocator does this to reserve the hardware input and output buses).

alloc(n = 1)

Return the starting index of a free block that is n slots wide. The default is 1 slot.

free(address)

Free a previously allocated block starting at address.

reserve(address, size = 1)

Mark a specific range of addresses as used so that the alloc method will not return any addresses within that range.


