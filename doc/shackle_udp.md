

# Module shackle_udp #
* [Data Types](#types)
* [Function Index](#index)
* [Function Details](#functions)

<a name="types"></a>

## Data Types ##




### <a name="type-backlog_size">backlog_size()</a> ###


<pre><code>
backlog_size() = pos_integer() | infinity
</code></pre>




### <a name="type-client_option">client_option()</a> ###


<pre><code>
client_option() = {init_options, <a href="#type-init_options">init_options()</a>} | {ip, <a href="#type-inet_address">inet_address()</a>} | {port, <a href="inet.md#type-port_number">inet:port_number()</a>} | {protocol, <a href="#type-protocol">protocol()</a>} | {reconnect, boolean()} | {reconnect_time_max, <a href="#type-time">time()</a> | infinity} | {reconnect_time_min, <a href="#type-time">time()</a>} | {socket_options, <a href="#type-socket_options">socket_options()</a>}
</code></pre>




### <a name="type-client_options">client_options()</a> ###


<pre><code>
client_options() = [<a href="#type-client_option">client_option()</a>]
</code></pre>




### <a name="type-inet_address">inet_address()</a> ###


<pre><code>
inet_address() = <a href="inet.md#type-ip_address">inet:ip_address()</a> | <a href="inet.md#type-hostname">inet:hostname()</a>
</code></pre>




### <a name="type-inet_port">inet_port()</a> ###


<pre><code>
inet_port() = <a href="inet.md#type-port_number">inet:port_number()</a>
</code></pre>




### <a name="type-init_options">init_options()</a> ###


<pre><code>
init_options() = term()
</code></pre>




### <a name="type-max_retries">max_retries()</a> ###


<pre><code>
max_retries() = non_neg_integer()
</code></pre>




### <a name="type-pool_option">pool_option()</a> ###


<pre><code>
pool_option() = {backlog_size, <a href="#type-backlog_size">backlog_size()</a>} | {max_retries, <a href="#type-max_retries">max_retries()</a>} | {pool_size, <a href="#type-pool_size">pool_size()</a>} | {pool_strategy, <a href="#type-pool_strategy">pool_strategy()</a>}
</code></pre>




### <a name="type-pool_options">pool_options()</a> ###


<pre><code>
pool_options() = [<a href="#type-pool_option">pool_option()</a>]
</code></pre>




### <a name="type-pool_size">pool_size()</a> ###


<pre><code>
pool_size() = pos_integer()
</code></pre>




### <a name="type-pool_strategy">pool_strategy()</a> ###


<pre><code>
pool_strategy() = random | round_robin
</code></pre>




### <a name="type-protocol">protocol()</a> ###


<pre><code>
protocol() = shackle_ssl | shackle_tcp | shackle_udp
</code></pre>




### <a name="type-request_id">request_id()</a> ###


<pre><code>
request_id() = {<a href="#type-server_name">server_name()</a>, reference()}
</code></pre>




### <a name="type-server_name">server_name()</a> ###


<pre><code>
server_name() = atom()
</code></pre>




### <a name="type-socket">socket()</a> ###


<pre><code>
socket() = <a href="inet.md#type-socket">inet:socket()</a> | <a href="ssl.md#type-sslsocket">ssl:sslsocket()</a>
</code></pre>




### <a name="type-socket_option">socket_option()</a> ###


<pre><code>
socket_option() = <a href="gen_tcp.md#type-connect_option">gen_tcp:connect_option()</a> | <a href="gen_udp.md#type-option">gen_udp:option()</a> | <a href="ssl.md#type-connect_option">ssl:connect_option()</a>
</code></pre>




### <a name="type-socket_options">socket_options()</a> ###


<pre><code>
socket_options() = [<a href="#type-socket_option">socket_option()</a>]
</code></pre>




### <a name="type-time">time()</a> ###


<pre><code>
time() = pos_integer()
</code></pre>

<a name="index"></a>

## Function Index ##


<table width="100%" border="1" cellspacing="0" cellpadding="2" summary="function index"><tr><td valign="top"><a href="#close-1">close/1</a></td><td></td></tr><tr><td valign="top"><a href="#connect-3">connect/3</a></td><td></td></tr><tr><td valign="top"><a href="#send-2">send/2</a></td><td></td></tr><tr><td valign="top"><a href="#setopts-2">setopts/2</a></td><td></td></tr></table>


<a name="functions"></a>

## Function Details ##

<a name="close-1"></a>

### close/1 ###

<pre><code>
close(Socket::<a href="#type-socket">socket()</a>) -&gt; ok
</code></pre>
<br />

<a name="connect-3"></a>

### connect/3 ###

<pre><code>
connect(Address::<a href="#type-inet_address">inet_address()</a>, Port::<a href="#type-inet_port">inet_port()</a>, SocketOptions::<a href="#type-socket_options">socket_options()</a>) -&gt; {ok, <a href="#type-socket">socket()</a>} | {error, atom()}
</code></pre>
<br />

<a name="send-2"></a>

### send/2 ###

<pre><code>
send(Socket::<a href="#type-socket">socket()</a>, Data::iodata()) -&gt; ok | {error, atom()}
</code></pre>
<br />

<a name="setopts-2"></a>

### setopts/2 ###

<pre><code>
setopts(Socket::<a href="#type-socket">socket()</a>, Opts::[<a href="gen_udp.md#type-option">gen_udp:option()</a>]) -&gt; ok | {error, atom()}
</code></pre>
<br />
