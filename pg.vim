" Vim syntax file
"
" Very loosely based on a Devrim Gunduz's attempt, which you can find at
" http://www.gunduz.org/postgresql/pgsql.vim.
"
" Language:	 pg

" Always ignore case
syn case ignore

syn match	pgSemicolon		";"

" Special values
syn keyword	pgSpecial		false null true

" Strings (single- and double-quote).  Don't do anything for dollar quotes, or
" function bodies will look like crap.
syn region	pgString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region	pgString		start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers and hexidecimal values
syn match	pgNumber		"-\=\<[0-9]*\>"
syn match	pgNumber		"-\=\<[0-9]*\.[0-9]*\>"
syn match	pgNumber		"-\=\<[0-9]*e[+-]\=[0-9]*\>"
syn match	pgNumber		"-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match	pgNumber		"\<0x[abcdefABCDEF0-9]*\>"

" Comments
syn keyword	pgTodo			TODO FIXME XXX BUG contained
syn region	pgMultiComment	start="/\*"  end="\*/" contains=pgMultiComment,pgTodo
syn region	pgComment		start="--" end="$" contains=pgTodo
hi def link	pgMultiComment	pgComment

hi def link pgTodo			Todo
syn sync	ccomment		pgComment

" Column types

syn keyword	pgType			anyarray anyelement abstime anyenum
syn keyword	pgType			anynonarray any aclitem bytea bigserial
syn keyword	pgType			bit boolean bigint box cidr cstring char
syn keyword	pgType			character cid circle decimal double date
syn keyword	pgType			enum gtsvector hstore inet interval
syn keyword	pgType			internal int2vector int integer line lseg
syn keyword	pgType			language_handler macaddr money numeric
syn keyword	pgType			name opaque oidvector oid polygon point
syn keyword	pgType			path period precision regclass real
syn keyword	pgType			regtype refcursor regoperator reltime
syn keyword	pgType			record regproc regdictionary regoper
syn keyword	pgType			regprocedure regconfig smgr smallint
syn keyword	pgType			serial smallserial time tsquery tinterval
syn keyword	pgType			trigger tid timestamptz text
syn keyword	pgType			tsvector txid_snapshot unknown uuid void
syn keyword	pgType			varchar varying xml xid

syn match	pgType			"timestamp\>"
syn match	pgType			"timestamp with time zone\>"
syn match	pgType			"timestamp without time zone\>"
syn region	pgType			start="timestamp(" end=")" contains=pgNumber
syn region	pgType			start="timestamptz(" end=")" contains=pgNumber

syn region	pgType			start="float\>" end="."me=s-1
syn region	pgType			start="float(" end=")" contains=pgNumber
syn region	pgType			start="double precision\>" end="."me=s-1
syn region	pgType			start="double precision(" end=")" contains=pgNumber
syn region	pgType			start="real\>" end="."me=s-1
syn region	pgType			start="real(" end=")" contains=pgNumber
syn region	pgType			start="numeric(" end=")" contains=pgNumber
syn region	pgType			start="decimal(" end=")" contains=pgNumber
syn region	pgType			start="char(" end=")" contains=pgNumber
syn region	pgType			start="varchar(" end=")" contains=pgNumber

" Logical, string and numeric operators
syn keyword	pgOperator		between not and is in like regexp rlike binary exists

" PL/PgSQL control flow
syn keyword	plpgsqlFlow		if then else elsif
syn keyword	plpgsqlFlow		continue exit raise return
syn keyword	plpgsqlFlow		declare begin exception end
syn keyword	plpgsqlFlow		loop foreach
" this must be a match to allow FOR UPDATE etc. to take priority
syn match	plpgsqlFlow		"for\>"

" A label (for e.g. a loop) in PL/PgSQL
syn region	plpgsqlLabel	start="<<[^+\-\*/<>=\~!@#%\^&|`?]" end=">>"

" Assignments in PL/PgSQL
syn match	plpgsqlAssignment	"into\(\s\+strict\)\?\>"
syn match	plpgsqlAssignment	":="

" distinguish between INSERT INTO and SELECT .. INTO .. in PL/PgSQL; overrides
" plpgsqlAssignment, above.
syn region	pgKeyword	start="\<insert\>" end="\<into\>"

" General keywords
syn match	pgKeyword	"for \(update\|\(no key update\)\|share\|\(key share\)\)\>"
syn match	pgKeyword	"\<strict\>"
syn match	pgKeyword	"\<with\>"

syn match   pgKeyword   "\<or\(\s\+replace\>\)\?\>"
syn keyword pgKeyword	abort alter aggregate analyze and array as alias all add
syn keyword pgKeyword	by before
syn keyword pgKeyword	conversion cascade current_date current_time current_timestamp class close
syn keyword pgKeyword	cluster checkpoint check comment
syn keyword pgKeyword	cast cascade check column columns constraint create copy
syn keyword pgKeyword	database domain databases default delete distinct drop deallocate desc
syn keyword pgKeyword	deferrable deferred defaults do diagnostics
syn keyword pgKeyword	explain exists execute exclusion found except each
syn keyword pgKeyword	function foreign from full fetch first force
syn keyword pgKeyword	group grant global get
syn keyword pgKeyword	having
syn keyword pgKeyword	index immutable inner initially immediate inherits instead in inout
syn keyword pgKeyword	join
syn keyword pgKeyword	key
syn keyword pgKeyword	language lock local limit left load last
syn keyword pgKeyword	max min move match
syn keyword pgKeyword	notify no nowait new nulls next
syn keyword pgKeyword	operator outer order old on out open only
syn keyword pgKeyword	prepare primary privilege procedure partial prepared
syn keyword pgKeyword	partition preserve perform
syn keyword pgKeyword	role reindex release reset revoke rollback references row rows rowtype rule restrict
syn keyword pgKeyword	returns returning
syn keyword pgKeyword	select set schema sequence savepoint simple system stable setof
syn keyword pgKeyword	truncate to transaction trigger table tables temp temporary tablespace type
syn keyword pgKeyword	update unique unlisten union using
syn keyword pgKeyword	verbose view values varying vacuum
syn keyword pgKeyword	when where

" CASE .. WHEN .. ELSE .. END;  needs special handling to avoid the fact that
" THEN is a PL/PgSQL keyword
syn keyword	pgCWKeyword	when then else contained
syn region	pgCaseWhen	matchgroup=pgCWKeyword start="case\>" end="end\>" contains=ALLBUT,plpgsqlAssignment,plpgsqlFlow,plpgsqlLabel transparent


" Use these, or don't
hi def link	pgKeyword	Statement
hi def link	pgSpecial	Special
hi def link	pgString	Constant
hi def link	pgNumber	Constant
hi def link	pgComment	Comment
hi def link	pgType		Type
hi def link	pgOperator	Statement
hi def link	plpgsqlFlow	PreProc

let b:current_syntax = "pg"
