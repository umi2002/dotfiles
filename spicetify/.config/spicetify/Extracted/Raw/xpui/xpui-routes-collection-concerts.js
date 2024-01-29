"use strict";(("undefined"!=typeof self?self:global).webpackChunkopen=("undefined"!=typeof self?self:global).webpackChunkopen||[]).push([[5835],{91377:(e,t,n)=>{n.d(t,{Z:()=>f});var a=n(50959),s=n(29482),o=n(83665),i=n(94989),r=n(98582),c=n(92540);const l="MUiWCNTfb6FcSwVPvQ1V",d="UAk3bMhekwJTV_wIyfsT",m="X9w6LPfKsZHMCs38sVIQ",g="NXn5KjeUOjLGlAfS1Gao",u="N0wgFMDDvCiby4QB5kLJ",v="nloNe2BLRHjz9dxlwfLU",h="FyD0hF1e2PKzRxQ6sYDQ",p="JzXND83mXvcEuntCNR34",x="GR08E4L_rOGljyQQX30R";var j=n(11527);const f=(0,a.memo)((e=>{const{uri:t,title:n,imageUrl:a,date:f,location:y,firstParty:N,onClick:k}=e,_=(0,c.CH)(f);return(0,j.jsxs)(i.Link,{to:t,className:l,"data-testid":"concert-card",onClick:k,children:[a&&(0,j.jsx)(r.Z,{children:(0,j.jsx)("div",{role:"img",className:x,style:{backgroundImage:`linear-gradient(180deg, rgba(18, 18, 18, 0) 0%, rgba(6, 6, 6, 0.6) 60%, rgba(0, 0, 0, 0.7) 100%), url(${a})`}})}),(0,j.jsx)("time",{className:d,dateTime:f,children:(0,j.jsx)(s.D,{as:"div",variant:"mestoBold",children:(0,c.jx)(_)})}),(0,j.jsxs)("div",{className:m,dir:"auto",children:[(0,j.jsx)(s.D,{as:"p",className:p,variant:"mesto",children:[(0,c.FO)(_),(0,c.hK)(_)].join(" • ")}),(0,j.jsx)(s.D,{as:"h2",variant:"cello",weight:"bold",className:g,children:n}),(0,j.jsxs)("div",{className:u,children:[N&&(0,j.jsx)("span",{className:h,children:(0,j.jsx)(o.V,{iconSize:16})}),(0,j.jsx)(s.D,{as:"span",className:v,variant:"mesto","data-testid":"location-name",children:y})]})]})]})}))},91564:(e,t,n)=>{n.d(t,{Z:()=>d});var a=n(50959),s=n(38762),o=n(98900),i=n(33604),r=n(46751),c=n(91377),l=n(11527);const d=(0,a.memo)((e=>{const{concert:t,isVirtual:n,onClick:a}=e,{venue:d,location:m}=t,g=t.artists[0];return(0,l.jsx)(c.Z,{uri:(0,s.g3)(t.id).toURI(),title:(0,r.ij)(t),imageUrl:g.imageUri,date:t.startDate.localDate,location:n?d:[d,m].join(o.ag.getSeparator()),firstParty:(0,i.$R)(t),onClick:a})}))},33604:(e,t,n)=>{n.d(t,{$R:()=>c,DF:()=>g,Vv:()=>d,ie:()=>u,k9:()=>r,pm:()=>m,sk:()=>l,yI:()=>o});n(95101),n(27396);var a=n(85487),s=n(67898);const o=(e,t)=>{if(!e)return"/concerts";const n=t?.normalize().replaceAll(/\W+/g,"-");return n?`/concerts/location/${e}-${n}`:`/concerts/location/${e}`},i=10;function r(e){if(0===e.length)return[];if(0===e[0].events.length)return[];const t=[];let n={date:e[0].events[0].openingDate.slice(0,i),events:[]};for(const a of e)for(const e of a.events){const a=e.openingDate.slice(0,i);n.date!==a&&(t.push(n),n={date:a,events:[]}),n.events.push(e)}return t.push(n),t}const c=e=>e.ticketers.some((e=>"spotify"===e.partnerDisplayName.toLowerCase())),l=e=>e.concerts.some((({concert:e})=>c(e))),d=e=>{const t=new Date(e);t.setDate(e.getDate()+(6-e.getDay()));const n=new Date(t);return n.setDate(t.getDate()+1),{from:t,to:n}},m=e=>{const t=new Date(e);t.setDate(e.getDate()+(6-e.getDay()));const n=new Date(t);n.setDate(t.getDate()+7);const a=new Date(n);return a.setDate(n.getDate()+1),{from:n,to:a}},g=(e,t)=>!!(e?.from&&e?.to&&t?.from&&t?.to)&&((0,a.Z)(e.from,t.from)&&(0,a.Z)(e.to,t.to)),u=e=>(0,s.Z)(e,{representation:"date"})},53442:(e,t,n)=>{n.r(t),n.d(t,{default:()=>on});var a=n(50959),s=n(40587),o=n(5311),i=n(22741),r=n(17599),c=n(35118),l=n(8319),d=n(49314),m=n(45917),g=n(20372),u=n(65456),v=n(58665),h=n(62171),p=n(98900),x=n(71856),j=n(7146),f=n(55085),y=n(31926),N=n(12864),k=n(42189),_=n(26265),D=(n(99692),n(85487)),C=n(29482),I=n(29535),S=n(94347),b=n(92180),L=n(27293),F=n(1922),w=n(77671),E=n(92369),U=n(79409),P=n(59486),O=n(83665),G=n(7769),B=n(85733),M=n(65742),R=n(94989),A=n(33604),H=n(92540),T=n(46751);const z="cELOd04or4B6BbTbNWA7",W="CHJYbX33oDik9u4n4ohH",$="woQ0wEe6FL4lsGW05bsb",V="KTDREr8pDWjrmnzXzZ2z",Z="UUTvdEOH2v_rejoXdl9Z",Q="cBbTozR921ppaoNZP0Uh",J="SNyyQ0t_VvlWzzB9li7v",K="lwO4iko6mhCUgZN1s9AW",q="akvZI06vqHOow1pOL29J",X="WWZp3WM0maWJzl2qWEHE",Y="YdkAHxbDekz9SiAxHG6M",ee="AK37djOBJ2BuJOGuG1kQ",te="JfYURQbEA_ntMsMZV6tK",ne="du0mOGaZfHg3hsHwRMIu",ae="Rvzy4ltiiHIp9mvlxf0c",se="uEXt8BtfJCONUNVYrAHn";var oe=n(11527);const ie=(0,a.memo)((e=>{const{concert:t,position:n,modalSpec:s}=e,{id:o,venue:i,location:r}=t,c=t.startDate.localDate,l=(0,H.CH)(c),d="ONLINE"===t.category,m=(0,a.useMemo)((()=>s?.eventRowFactory({position:n,uri:`spotify:concert:${t.id}`})),[s,n,t]),g=(0,k.$P)();return(0,oe.jsxs)(R.Link,{to:`/concert/${t.id}`,className:K,onClick:()=>{m&&g.logInteraction(m.hitUiNavigate({destination:`/concert/${o}`}))},children:[(0,oe.jsxs)("div",{className:q,"aria-hidden":!0,children:[(0,oe.jsx)(C.D,{as:"div",variant:"finaleBold",className:X,children:(0,H.jw)(l)}),(0,oe.jsx)(C.D,{as:"div",variant:"cello",className:Y,children:(0,H.wf)(l)})]}),(0,oe.jsxs)("div",{className:ee,children:[(0,oe.jsx)(C.D,{as:"div",variant:"violaBold",className:te,"data-testid":"event-title",children:(0,T.Yl)(t)}),(0,oe.jsx)(P.T,{children:(0,H.jx)(l)}),(0,oe.jsxs)(C.D,{as:"div",variant:"viola",className:ne,children:[(0,H.FO)(l)," • ",(0,H.hK)(l)]}),(0,oe.jsx)("span",{className:se,children:(0,A.$R)(t)&&(0,oe.jsx)(O.V,{iconSize:16})}),(0,oe.jsx)(C.D,{as:"div",variant:"viola",className:ae,"data-testid":"event-venue",children:d?i:[i,r].join(p.ag.getSeparator())})]})]},t.id)})),re=(0,a.memo)((e=>{const{event:t,locationName:n,onClose:s,feedSpec:o}=e,i=t?.concerts[0]?.concert,r=i?.artists[0],c=(0,a.useMemo)((()=>o?.groupedEventModalFactory({uri:r?.uri||""})),[o,r]),l=(0,k.$P)(),d=(0,k.Wi)(c);if(!t||!i||!r)return null;const m=()=>{c&&l.logInteraction(c.closeButtonFactory().hitUiHide()),s()};return(0,oe.jsx)(M.Z,{contentLabel:p.ag.get("live_events.label"),isOpen:!0,className:z,onRequestClose:m,children:(0,oe.jsxs)("section",{className:W,ref:d,children:[(0,oe.jsx)("div",{className:$,children:(0,oe.jsx)(ce,{"aria-label":p.ag.get("close"),iconOnly:G.k,buttonSize:"sm",onClick:m})}),(0,oe.jsxs)("div",{className:V,children:[(0,oe.jsx)(B.E,{height:"48",width:"48",className:Z,src:r.imageUri}),(0,oe.jsxs)("div",{className:Q,children:[(0,oe.jsx)(C.D,{as:"h3",variant:"cello",className:J,"data-testid":"event-venue",children:r.name}),(0,oe.jsx)(C.D,{as:"h3",variant:"mesto","data-testid":"event-venue",children:`${p.ag.get("concerts.count_near_location",t.concerts.length,n)}`})]})]}),t.concerts.map(((e,t)=>(0,oe.jsx)(ie,{concert:e.concert,position:t,modalSpec:c},e.concert.id)))]})})}));var ce=(0,U.ZP)(m.o).withConfig({displayName:"ConcertFeedGroupedModal___StyledButtonTertiary",componentId:"sc-1o845wh-0"})({color:"#FFFFFF",backgroundColor:"#000000",cursor:"pointer"}),le=n(39017),de=n(5750),me=n(85350);const ge=async()=>(await(0,me.rD)(de.b.getInstance())).body,ue=e=>{const[,{geonameId:t}]=e.queryKey;return(async e=>(await(0,me.$0)(de.b.getInstance(),e)).body)(t)},ve=e=>{const[,,t]=e.queryKey;return(async(e=1,t)=>{const{geonameId:n,startDate:a,endDate:s}=t;return(await(0,me.ij)(de.b.getInstance(),{page:e,geonameId:n,startDate:a,endDate:s})).body})(e.pageParam,t)},he=e=>{const[,,{geonameId:t}]=e.queryKey;return(async e=>(await(0,me.YA)(de.b.getInstance(),void 0,e)).body)(t)},pe=e=>{const[,,{geonameId:t}]=e.queryKey;return(async e=>(await(0,me.wr)(de.b.getInstance(),e)).body)(t)},xe=6e5,je=/^(\d+)/,fe=e=>{const t=e?.match(/(202\d)-([01]\d)-([0-3]\d)/);if(!t)return;const[,n,a,s]=t;return new Date(parseInt(n,10),parseInt(a,10)-1,parseInt(s,10))},ye=e=>{const t=(()=>{const{location:e}=(0,o.UO)(),[,t]=e?.match(je)||[];if(t)try{return parseInt(t,10)}catch(e){return}})(),[n]=(0,i.lr)(),a=n.get("filter")?.trim();return e.isAnonymous&&!a||"all"===a?{type:"all",geonameId:t}:e.isInterestedEnabled&&"saved"===a?{type:"saved"}:"first_party"===a?{type:"first_party",geonameId:t}:{type:"foryou",geonameId:t}};var Ne=n(63148),ke=n(67301);const _e="MVPegsivznZB6gdkcnkH",De="MlK79hskRbFrN2OBjMkl",Ce="VxaXFH9Uq1NU0LtsVhIu",Ie="UDVDNa40iTSPS9uHCG7Q",Se="vktIWsUczavLRrl4SkRt",be="Y1JeRPqrmHKXI1KcstYN",Le="ofURwIKv0qEXJGTraIis",Fe="fN_lJHkYih9H3j9YSEzS",we="LOJZO2MnGW5dCIawF767",Ee="tyc7QRlEJigVFIAeLGOB",Ue="PoljWhTLU3MKqIx2gSPY",Pe="ajxCNAuBJSgYfKUUBWBT",Oe="WR2h2Li5XTrBn_Rdme_k",Ge="WNhsvOyu4doInF525pLE",Be="qSR4imCvzdznIQ4F2kBO",Me="BCDMgFFqzEyzC1UqkW3t",Re="jFxUCv1gagc6erXmpgYw",Ae="XOS1JS9iDK8dgeF3GeL5",He="LNAJMvRlTPqWsmZvV7Kg",Te="jP10ZUl0Jn2Ijue3fZux",ze="ncN9bwTgIRk6xruAt5T8",We="hKG8XDR5S00bjBAibgbI",$e="XMhrCtHCVSPsNW67vM1m",Ve="vT0t_YE1HgmbnHLLhJD9",Ze=(0,a.memo)((e=>{const{geonameId:t,locationName:n,spec:s}=e,[o,i]=(0,a.useState)(!1),r=(0,k.Wi)(s),c=`https://concerts.spotifycdn.com/feed_city_images_1/${t}.jpg`;return(0,a.useEffect)((()=>{const e=()=>{i(!0)},t=()=>{i(!1)},n=new Image;return n.addEventListener("load",e),n.addEventListener("error",t),n.src=c,()=>{n.removeEventListener("load",e),n.removeEventListener("error",t)}}),[c]),(0,oe.jsx)(oe.Fragment,{children:(0,oe.jsxs)("div",{className:We,ref:r,children:[o&&(0,oe.jsx)(B.E,{src:c,className:$e,circle:!0,imageHeight:"56px",imageWidth:"56px"}),(0,oe.jsxs)("div",{children:[(0,oe.jsx)(C.D,{variant:"ballad",semanticColor:"textSubdued",as:"p",children:p.ag.get("live_events.city_info_find_tickets",n)}),(0,oe.jsx)(C.D,{variant:"ballad",semanticColor:"textSubdued",as:"p",children:p.ag.get("live_events.city_info_view_details")})]})]})})}));var Qe=n(54083),Je=(n(61362),n(30068)),Ke=n(95306);const qe="eFIu3aQJuKmf6H4Lb18K",Xe="LPNL3DZ89Iisp8TMArD3",Ye="moVCbo9Ao5YJ5PsH4Qdz",et="URXDMjhb8pQWIDaBrCPC",tt="a3oYct1knu9af60A0v6g",nt="qbIrubbolsixlgVkhO5r",at="xHihsEV_0W6kpm0wHsXA",st="T8po_YH39Q9dhAsLAhec",ot={formatCaption:e=>p.ag.formatDate(e,{month:"long",year:"numeric"}),formatDay:e=>p.ag.formatDate(e,{day:"numeric"}),formatWeekdayName:e=>p.ag.formatDate(e,{weekday:"short"})},it=(0,a.memo)((e=>{const{onDone:t,onClose:n,spec:s}=e,[o,i]=(0,a.useState)(e.dateRange),r=(0,Ke.S)(),c=(0,k.Wi)(s),l=(0,k.$P)(),d=new Date,g=(0,A.Vv)(d),u=(0,A.pm)(d),v=(0,A.DF)(o,g),h=(0,A.DF)(o,u);return(0,oe.jsx)("div",{ref:c,children:(0,oe.jsx)(M.Z,{isOpen:!0,children:(0,oe.jsxs)("section",{className:qe,children:[(0,oe.jsx)(m.o,{className:Xe,iconOnly:G.k,size:"small",onClick:n,"aria-label":p.ag.get("close_button_action")}),(0,oe.jsxs)("div",{className:Ye,children:[(0,oe.jsx)(C.D,{as:"h3",variant:"cello",children:p.ag.get("live_events.date_picker_dialog_title")}),(0,oe.jsxs)("div",{className:et,children:[(0,oe.jsx)(b.A,{className:tt,size:"md",selectedColorSet:"brightAccent",selected:v,onClick:()=>{i(v?void 0:g),s&&l.logInteraction(s.datePresetButtonFactory({identifier:"thisWeekend",position:0}).hitUiSelect())},children:p.ag.get("live_events.this_weekend_preset")}),(0,oe.jsx)(b.A,{className:tt,size:"md",selectedColorSet:"brightAccent",selected:h,onClick:()=>{i(h?void 0:u),s&&l.logInteraction(s.datePresetButtonFactory({identifier:"nextWeekend",position:1}).hitUiSelect())},children:p.ag.get("live_events.next_weekend_preset")})]})]}),(0,oe.jsx)(Qe._W,{mode:"range",selected:o,onSelect:i,numberOfMonths:2,defaultMonth:e.dateRange?.from,fromDate:new Date,formatters:ot,dir:r?"rtl":"ltr",modifiersClassNames:{today:nt}}),(0,oe.jsxs)("div",{className:at,children:[(0,oe.jsx)(m.o,{className:st,size:"small",onClick:()=>{i(void 0)},disabled:!o?.from,children:p.ag.get("live_events.date_picker_dialog_clear")}),(0,oe.jsx)(Je.D,{size:"small",onClick:()=>{if(o?.from){const{from:e,to:n}=o;t({from:e,to:n||e})}else t()},children:p.ag.get("live_events.date_picker_dialog_done")})]})]})})})}));var rt=n(38762),ct=n(91564),lt=n(98582);const dt="pU4WoqT8T6PmtjPbFtK0",mt="FC5Y_KFJ9rJyTpydqtOW",gt="AAYLcavkBdCuebn9AQxT",ut="lYHCmxpdReachiOORWGo",vt="JtKEdtTtcK7s6EpGecaC",ht="XuH9DoZCf0aVJ2BxQkTB",pt="myHDa69cI5CHC8fhIhkG",xt=(0,a.memo)((e=>{const{event:t,onClick:n}=e,s=(0,a.useCallback)((()=>n(t)),[t,n]),o=(0,H.CH)(t.openingDate),i=(0,H.CH)(t.closingDate),r=t.concerts[0].concert,c=r.artists[0];return(0,oe.jsxs)(m.o,{onClick:s,className:dt,component:"div","data-testid":"concert-card",role:"button",children:[c.imageUri&&(0,oe.jsx)(lt.Z,{children:(0,oe.jsx)("div",{role:"img",className:pt,style:{backgroundImage:`linear-gradient(180deg, rgba(18, 18, 18, 0) 0%, rgba(6, 6, 6, 0.6) 60%, rgba(0, 0, 0, 0.7) 100%), url(${c.imageUri})`}})}),(0,oe.jsx)("time",{className:mt,dateTime:o.toISOString(),children:(0,oe.jsx)(C.D,{as:"p",variant:"mestoBold",children:(0,H.Bc)(o,i)})}),(0,oe.jsxs)("div",{className:gt,dir:"auto",children:[(0,oe.jsx)(C.D,{as:"h2",variant:"cello",weight:"bold",className:ut,children:(0,T.ij)(r)}),(0,oe.jsxs)("div",{className:vt,children:[(0,A.sk)(t)&&(0,oe.jsx)("span",{className:ht,children:(0,oe.jsx)(O.V,{iconSize:16})}),(0,oe.jsx)(C.D,{as:"span",variant:"mesto","data-testid":"concerts-count",children:p.ag.get("concerts.count",t.concerts.length)})]})]})]})})),jt=(0,a.memo)((e=>{const{event:t,position:n,sectionSpec:s,onOpenGroupedEvent:o}=e,i=t.concerts[0]?.concert,r=i?.id,c=i&&(0,rt.g3)(i.id).toURI(),l=(0,k.$P)(),d=(0,a.useMemo)((()=>s?.eventCardFactory({identifier:r??"",position:n,uri:c??""})),[s,r,c,n]),m=(0,k.Wi)(d),g=e=>{o(e),d&&l.logInteraction(d.hitUiReveal())};if(t.concerts.length>1)return(0,oe.jsx)("div",{ref:m,children:(0,oe.jsx)(xt,{event:t,onClick:g})});return(0,oe.jsx)("div",{ref:m,children:(0,oe.jsx)(ct.Z,{concert:i,isVirtual:"online"===t.source,onClick:()=>{d&&l.logInteraction(d.hitUiNavigate({destination:c}))}})})})),ft="yLIDHkmBrjsAVNMCcFM_",yt="qr_9NXyk7D0t6wclM5R0",Nt="mDxkFuOd3TBAQI2gXatq",kt="AQ8ZFs5U45GPiyJnqEvt",_t="E8DcbdVmmoGfC8R8S1Vw",Dt="wzS5PwxEhferQEdjumt0",Ct="E0zwnbwA3HzqNi2BV4eq",It=(0,a.memo)((e=>{const{event:t,onClick:n}=e,s=(0,a.useCallback)((()=>n(t)),[t,n]),o=(0,H.CH)(t.openingDate),i=(0,H.CH)(t.closingDate),r=t.concerts[0].concert,c=r.artists[0];return(0,oe.jsxs)("div",{className:Dt,onClick:s,onKeyPress:s,role:"link",tabIndex:0,children:[(0,oe.jsx)(B.E,{src:c?.imageUri,alt:"",role:"presentation",className:ft}),(0,oe.jsxs)("div",{className:yt,children:[(0,oe.jsx)(C.D.span,{variant:"cello",className:Nt,"data-testid":"event-title",children:(0,T.ij)(r)}),(0,oe.jsx)(C.D.span,{variant:"ballad",className:kt,children:(0,H.Bc)(o,i)}),(0,oe.jsxs)(C.D.span,{variant:"ballad",className:_t,"data-testid":"event-venue",children:[(0,A.sk)(t)&&(0,oe.jsx)(O.V,{iconSize:16,className:Ct}),p.ag.get("concerts.count",t.concerts.length)]})]})]})})),St=(0,a.memo)((e=>{const{concert:t,isVirtual:n,onClick:a}=e,{venue:s,location:o}=t,i=t.artists[0],r=(0,H.CH)(t.startDate.localDate);return(0,oe.jsxs)(R.Link,{to:`/concert/${t?.id}`,className:Dt,"data-testid":"concert-row",onClick:a,children:[(0,oe.jsx)(B.E,{src:i?.imageUri,alt:"",role:"presentation",className:ft}),(0,oe.jsxs)("div",{className:yt,children:[(0,oe.jsx)(C.D.span,{variant:"cello",className:Nt,"data-testid":"event-title",children:(0,T.ij)(t)}),(0,oe.jsxs)(C.D.span,{variant:"ballad",className:kt,children:[(0,H.xE)(r)," • ",(0,H.hK)(r)]}),(0,oe.jsxs)(C.D.span,{variant:"ballad",className:_t,"data-testid":"event-venue",children:[(0,A.$R)(t)&&(0,oe.jsx)(O.V,{iconSize:16,className:Ct}),n?s:[s,o].join(p.ag.getSeparator())]})]})]})})),bt=(0,a.memo)((e=>{const{event:t,position:n,sectionSpec:s,onOpenGroupedEvent:o}=e,i=t.concerts[0]?.concert,r=i?.id,c=i&&(0,rt.g3)(i.id).toURI(),l=(0,k.$P)(),d=(0,a.useMemo)((()=>s?.eventRowFactory({identifier:r??"",position:n,uri:c??""})),[s,r,c,n]),m=(0,k.Wi)(d),g=e=>{o(e)};if(t.concerts.length>1)return(0,oe.jsx)("div",{ref:m,children:(0,oe.jsx)(It,{event:t,onClick:g})});return(0,oe.jsx)("div",{ref:m,children:(0,oe.jsx)(St,{concert:i,isVirtual:"online"===t.source,onClick:()=>{d&&l.logInteraction(d.hitUiNavigate({destination:c??""}))}})})})),Lt=(0,a.memo)((e=>{const{eventGroups:t,locationName:n,isLoading:s,feedSpec:o,onOpenGroupedEvent:i,layout:r}=e,c=(0,a.useMemo)((()=>o?.eventSectionFactory({identifier:"all",position:1})),[o]),l=(0,k.Wi)(c);return s?(0,oe.jsx)(w.h,{hasError:!1,errorMessage:""}):t?0===t.length||0===t[0].events.length?(0,oe.jsx)(F.u,{title:p.ag.get("concerts.error.no_concerts_found_title"),message:p.ag.get("concerts.error.no_concerts_found_message",n),renderInline:!0}):(0,oe.jsx)("div",{ref:l,children:t.map((e=>(0,oe.jsxs)("div",{className:Ge,children:["grid"===r&&(0,oe.jsx)(E.P,{total:e.events.length,title:p.ag.formatDate(new Date(`${e.date}T00:00:00`),{weekday:"long",day:"numeric",month:"long",year:"numeric"}),showAll:!0,children:e.events.map(((e,t)=>{const n=e.concerts[0]?.concert;return(0,oe.jsx)(jt,{event:e,position:t,sectionSpec:c,onOpenGroupedEvent:i},n?.id)}))}),"list"===r&&(0,oe.jsxs)("div",{children:[(0,oe.jsx)(C.D,{as:"h2",variant:"canon",semanticColor:"textBase",className:Se,children:p.ag.formatDate(new Date(`${e.date}T00:00:00`),{weekday:"long",day:"numeric",month:"long",year:"numeric"})}),e.events.map(((e,t)=>{const n=e.concerts[0]?.concert;return(0,oe.jsx)(bt,{event:e,position:t,sectionSpec:c,onOpenGroupedEvent:i},n?.id)}))]})]},e.date)))}):null})),Ft={month:"short",day:"numeric"},wt=e=>{if((0,D.Z)(e.from,e.to))return p.ag.formatDate(e.from,Ft);return`${p.ag.formatDate(e.from,Ft)} - ${p.ag.formatDate(e.to,Ft)}`},Et=(0,a.memo)((e=>{const{geonameId:t,spec:n,layout:s,onLocationNameChange:r}=e,c=(()=>{const[e]=(0,i.lr)(),t=e.get("startDate")?.trim(),n=e.get("endDate")?.trim(),a=fe(t),s=fe(n);return a&&s&&{from:a,to:s}})(),l=(0,o.s0)(),[,d]=(0,i.lr)(),[m]=(0,i.lr)(),[g,u]=(0,a.useState)(),[v,h]=(0,a.useState)(!1),x=(0,ke.o)(),j=(0,a.useMemo)((()=>n?.headerFactory()),[n]),f=(0,a.useMemo)((()=>n?.datePickerModalFactory()),[n]),y=(0,a.useMemo)((()=>n?.cityInfoFactory()),[n]),N=(0,k.$P)(),{data:_,isLoading:D,hasNextPage:F,isFetchingNextPage:w,fetchNextPage:E}=(U={geonameId:t,startDate:c&&(0,A.ie)(c.from),endDate:c&&(0,A.ie)(c.to)},(0,le.useInfiniteQuery)(["concerts","all",U],ve,{staleTime:xe,keepPreviousData:!0,getNextPageParam:(e,t)=>{if(!(t.length>=50)&&0!==e.events.length)return t.length+1}}));var U;const P=(0,a.useMemo)((()=>(0,A.k9)(_?.pages??[])),[_?.pages]),O=_?.pages[0]?.userLocation;(0,a.useEffect)((()=>{O&&r?.(O)}),[O,r]);const G=O||p.ag.get("concerts.default_location"),B=(0,A.Vv)(new Date),M=(0,A.pm)(new Date),R=(0,a.useCallback)((e=>{const t={filter:"all"};if(e&&(t.startDate=(0,A.ie)(e.from),t.endDate=(0,A.ie)(e.to),f)){const e=new URLSearchParams(t).toString();N.logInteraction(f.doneButtonFactory({uri:e}).hitUiNavigate({destination:e}))}h(!1),d(t),f&&N.logInteraction(f.doneButtonFactory({uri:new URLSearchParams(t).toString()}).hitUiHide())}),[d,f,N]),H=(0,a.useCallback)((e=>{const t={filter:"all"};(0,A.DF)(c,e)||(t.startDate=(0,A.ie)(e.from),t.endDate=(0,A.ie)(e.to)),d(t)}),[c,d]);return(0,oe.jsxs)("div",{children:[(0,oe.jsx)(L.$,{children:`${p.ag.get("concerts_shows_in")} ${G}`}),(0,oe.jsxs)("div",{className:Re,children:[(0,oe.jsx)(Ne.Z,{handleLocationChange:e=>{x({type:"click",intent:"change-live-events-location"}),e?.geonameId&&l({pathname:(0,A.yI)(e.geonameId,e.location),search:`?${m.toString()}`})},locationStr:G,headerSpec:j}),(0,oe.jsxs)(oe.Fragment,{children:[(0,oe.jsx)(I.P,{className:Me,iconLeading:S.a,onClick:()=>{h(!0),j&&N.logInteraction(j.datePickerButtonFactory().hitUiReveal())},size:"small",children:c?wt(c):p.ag.get("live_events.date_picker_button_text")}),v&&(0,oe.jsx)(it,{onClose:()=>{h(!1),f&&N.logInteraction(f.closeButtonFactory().hitUiHide())},onDone:R,dateRange:c,spec:f}),(0,oe.jsx)(b.A,{className:Ae,size:"sm",selectedColorSet:"brightAccent",selected:(0,A.DF)(c,B),onClick:()=>{if(H(B),j){const e={startDate:(0,A.ie)(B.from),endDate:(0,A.ie)(B.to)},t=new URLSearchParams(e).toString();N.logInteraction(j.datePresetButtonFactory({uri:t,identifier:"thisWeekend",position:0}).hitUiNavigate({destination:t}))}},children:p.ag.get("live_events.this_weekend_preset")}),(0,oe.jsx)(b.A,{className:Ae,size:"sm",selectedColorSet:"brightAccent",selected:(0,A.DF)(c,M),onClick:()=>{if(H(M),j){const e={startDate:(0,A.ie)(M.from),endDate:(0,A.ie)(M.to)},t=new URLSearchParams(e).toString();N.logInteraction(j.datePresetButtonFactory({uri:t,identifier:"nextWeekend",position:1}).hitUiNavigate({destination:t}))}},children:p.ag.get("live_events.next_weekend_preset")})]})]}),(0,oe.jsx)(Lt,{isLoading:D,locationName:G,eventGroups:P,onOpenGroupedEvent:e=>{u(e);const t=e.concerts[0]?.concert.artistUris[0];x({type:"click",intent:"open-grouped-live-event",targetUri:t})},feedSpec:n,layout:s}),F&&(0,oe.jsx)("div",{className:Be,children:(0,oe.jsx)(I.P,{disabled:w,onClick:()=>{E()},children:p.ag.get("concerts.load_more")})}),(0,oe.jsx)(re,{event:g,locationName:G,feedSpec:n,onClose:()=>u(void 0)}),(0,oe.jsx)(C.D,{variant:"finale",semanticColor:"textSubdued",children:p.ag.get("live_events.disclaimer")}),_&&_.pages[0]&&_.pages[0].userLocationGeonameId&&(0,oe.jsx)(Ze,{geonameId:_.pages[0].userLocationGeonameId,locationName:G,spec:y})]})}));var Ut=n(13664),Pt=n(24172),Ot=n(15192);const Gt=(0,a.memo)((e=>{const{title:t="",identifier:n,position:s,events:o,feedSpec:i,onOpenGroupedEvent:r,layout:c}=e,l=(0,a.useMemo)((()=>i?.eventSectionFactory({identifier:n,position:s})),[i,n,s]),d=(0,k.Wi)(l);return 0===o.length?null:(0,oe.jsxs)("div",{className:_e,ref:d,children:["grid"===c&&(0,oe.jsx)(Ot.JL,{value:"headered-grid",index:s,children:(0,oe.jsx)(E.P,{total:o.length,title:t,showAll:!0,children:o.map(((e,t)=>{const n=e.concerts[0]?.concert;return(0,oe.jsx)(jt,{event:e,position:t,sectionSpec:l,onOpenGroupedEvent:r},n?.id)}))})}),"list"===c&&(0,oe.jsxs)("div",{children:[(0,oe.jsx)(C.D,{as:"h2",variant:"canon",semanticColor:"textBase",className:Se,children:t}),o.map(((e,t)=>{const n=e.concerts[0]?.concert;return(0,oe.jsx)(bt,{event:e,position:t,sectionSpec:l,onOpenGroupedEvent:r},n?.id)}))]})]})})),Bt=(0,a.memo)((e=>{const{spec:t,layout:n,onLocationNameChange:s}=e,[r,c]=(0,a.useState)(),[l]=(0,i.lr)(),d=(m=e.geonameId,(0,le.useQuery)(["concerts","popular",{geonameId:m}],he,{staleTime:xe,keepPreviousData:!0}));var m;const g=d.data?.userLocation||p.ag.get("concerts.default_location"),u=(0,a.useMemo)((()=>t?.headerFactory()),[t]),v=(0,o.s0)();return(0,a.useEffect)((()=>{d.data?.userLocation&&s?.(d.data.userLocation)}),[d.data?.userLocation,s]),(0,oe.jsxs)("div",{children:[(0,oe.jsx)(L.$,{children:`${p.ag.get("concerts_shows_in")} ${g}`}),(0,oe.jsx)("div",{className:Re,"data-testid":"location-selector",children:(0,oe.jsx)(Ne.Z,{handleLocationChange:e=>{(0,Ut._)({type:"click",intent:"change-live-events-location"}),e?.geonameId&&v({pathname:(0,A.yI)(e.geonameId,e.location),search:`?${l.toString()}`})},locationStr:g,headerSpec:u})}),(0,oe.jsxs)("div",{className:He,children:[(0,oe.jsx)(C.D,{variant:"celloCanon",semanticColor:"textBase",children:p.ag.get("live_events.for_you_anonymous_heading")}),(0,oe.jsx)(C.D,{variant:"ballad",className:Te,semanticColor:"textSubdued",children:p.ag.get("live_events.for_you_anonymous_subheading")}),(0,oe.jsx)(Je.D,{colorSet:"invertedLight",className:ze,onClick:()=>(0,Pt.L6)(),children:p.ag.get("live_events.sign_up_free")})]}),d.data&&(0,oe.jsx)(Gt,{title:p.ag.get("concerts.popular_concerts_near",g),identifier:"popular",position:0,events:d.data.events,onOpenGroupedEvent:e=>{c(e);const t=e.concerts[0]?.concert.artistUris[0];(0,Ut._)({type:"click",intent:"open-grouped-live-event",targetUri:t})},feedSpec:t,layout:n}),(0,oe.jsx)(re,{event:r,locationName:g,feedSpec:t,onClose:()=>c(void 0)}),(0,oe.jsx)(C.D,{variant:"finale",semanticColor:"textSubdued",children:p.ag.get("live_events.disclaimer")}),d.data&&d.data.userLocationGeonameId&&(0,oe.jsx)(Ze,{geonameId:d.data.userLocationGeonameId,locationName:g})]})}));n(95101),n(3943);const Mt=(0,a.memo)((e=>{const{isLoading:t,events:n,locationName:a,spec:s,layout:o,onOpenGroupedEvent:i}=e;if(t)return(0,oe.jsx)(w.h,{hasError:!1,errorMessage:""});if(0===n.length)return(0,oe.jsx)(F.u,{title:p.ag.get("concerts.error.no_concerts_found_title"),message:p.ag.get("concerts.error.no_concerts_found_message",a),renderInline:!0});const r=(e=>{const t={popular:[],recommended:[],online:[]};return e.forEach((e=>{switch(e.source){case"recommendation":t.recommended.push(e);break;case"popular":t.popular.push(e);break;case"online":t.online.push(e)}})),t})(n);return(0,oe.jsxs)(oe.Fragment,{children:[(0,oe.jsx)(Gt,{title:p.ag.get("concerts_upcoming_virtual_events"),identifier:"online",position:0,events:r.online,onOpenGroupedEvent:i,feedSpec:s,layout:o}),(0,oe.jsx)(Gt,{title:p.ag.get("concerts_recommended_for_you"),identifier:"recommended",position:1,events:r.recommended,onOpenGroupedEvent:i,feedSpec:s,layout:o}),(0,oe.jsx)(Gt,{title:p.ag.get("concerts.popular_concerts_near",a),identifier:"popular",position:2,events:r.popular,onOpenGroupedEvent:i,feedSpec:s,layout:o})]})}));var Rt=n(74818),At=n(6401),Ht=n(96221),Tt=n(26850),zt=n(86612),Wt=n(45963);const $t={kind:"Document",definitions:[{kind:"OperationDefinition",operation:"query",name:{kind:"Name",value:"promoCardPlaylist"},variableDefinitions:[{kind:"VariableDefinition",variable:{kind:"Variable",name:{kind:"Name",value:"uri"}},type:{kind:"NonNullType",type:{kind:"NamedType",name:{kind:"Name",value:"ID"}}}}],selectionSet:{kind:"SelectionSet",selections:[{kind:"Field",name:{kind:"Name",value:"playlistV2"},arguments:[{kind:"Argument",name:{kind:"Name",value:"uri"},value:{kind:"Variable",name:{kind:"Name",value:"uri"}}}],selectionSet:{kind:"SelectionSet",selections:[{kind:"Field",name:{kind:"Name",value:"__typename"}},{kind:"InlineFragment",typeCondition:{kind:"NamedType",name:{kind:"Name",value:"Playlist"}},selectionSet:{kind:"SelectionSet",selections:[{kind:"FragmentSpread",name:{kind:"Name",value:"playlistInfo"}}]}}]}}]}},{kind:"FragmentDefinition",name:{kind:"Name",value:"playlistInfo"},typeCondition:{kind:"NamedType",name:{kind:"Name",value:"Playlist"}},selectionSet:{kind:"SelectionSet",selections:[{kind:"Field",name:{kind:"Name",value:"uri"}},{kind:"Field",name:{kind:"Name",value:"name"}},{kind:"Field",name:{kind:"Name",value:"images"},selectionSet:{kind:"SelectionSet",selections:[{kind:"Field",name:{kind:"Name",value:"items"},selectionSet:{kind:"SelectionSet",selections:[{kind:"Field",name:{kind:"Name",value:"sources"},selectionSet:{kind:"SelectionSet",selections:[{kind:"Field",name:{kind:"Name",value:"width"}},{kind:"Field",name:{kind:"Name",value:"height"}},{kind:"Field",name:{kind:"Name",value:"url"}}]}}]}}]}},{kind:"Field",name:{kind:"Name",value:"description"}}]}}]},Vt="Cot6ZntaldMo77XCx1dt",Zt="vfWT92cAm89qtD3Lwfrc",Qt="XyJgy3JOLfeFBo2CiltA",Jt="UI2hGxMrqbScQtyg3FzT",Kt="mnwdEtmP084CWa7aUEzN",qt=()=>{const e=(0,At.g)(),t=(0,a.useContext)(Tt.ZF),{data:n}=(0,le.useQuery)("cny-resolve",(()=>t.resolvePlaylistFormatURI("spotify:playlist-format:concerts-near-you")),{enabled:!e,staleTime:1/0}),{data:s}=(o={uri:n},i={enabled:!!n},(0,Wt.a)($t,o,i));var o,i;if("Playlist"===s?.playlistV2.__typename)return s.playlistV2},Xt=(0,a.memo)((e=>{const t=qt();if(!t)return null;const n=(0,zt.X)(t.images.items[0]?.sources,{desiredSize:88});return(0,oe.jsxs)(R.default,{to:t.uri,className:Vt,children:[(0,oe.jsx)(Ht.E,{src:n?.url,loading:"lazy",alt:"",ariaHidden:!0,className:Zt}),(0,oe.jsxs)("div",{className:Qt,children:[(0,oe.jsx)(C.D.h3,{variant:"balladBold",className:Jt,children:t.name}),(0,oe.jsx)(C.D.p,{variant:"mesto",className:Kt,children:t.description})]})]})})),Yt=(0,a.memo)((e=>{const{geonameId:t,spec:n,layout:s,onLocationNameChange:i}=e,r=(0,o.s0)(),[c,l]=(0,a.useState)(),d=(0,ke.o)(),m=(0,a.useMemo)((()=>n.headerFactory()),[n]),{data:g,isLoading:u}=(e=>{const t=(0,le.useQueryClient)();return(0,le.useQuery)(["concerts",e],ue,{staleTime:xe,keepPreviousData:!0,onSuccess(n){if(e.geonameId||!n.userLocationGeonameId)return;const a=parseInt(n.userLocationGeonameId,10),s=["concerts",{...e,geonameId:a}];t.setQueryData(s,(()=>n))}})})({geonameId:t});(0,a.useEffect)((()=>{g?.userLocation&&i?.(g.userLocation)}),[g?.userLocation,i]);const h=(0,v.W6)(Rt.yJ3,{loadingValue:!1}),x=g?.userLocation||p.ag.get("concerts.default_location");return(0,oe.jsxs)("div",{children:[(0,oe.jsx)(L.$,{children:`${p.ag.get("concerts_shows_in")} ${x}`}),(0,oe.jsx)("div",{className:Re,"data-testid":"location-selector",children:(0,oe.jsx)(Ne.Z,{handleLocationChange:e=>{d({type:"click",intent:"change-live-events-location"}),e?.geonameId&&r((0,A.yI)(e.geonameId,e.location))},locationStr:x,headerSpec:m})}),h&&(0,oe.jsx)("div",{className:Ve,children:(0,oe.jsx)(Xt,{})}),(0,oe.jsx)(Mt,{isLoading:u,events:g?.events||[],locationName:x,spec:n,onOpenGroupedEvent:e=>{l(e);const t=e.concerts[0]?.concert.artistUris[0];d({type:"click",intent:"open-grouped-live-event",targetUri:t})},layout:s}),(0,oe.jsx)(re,{event:c,locationName:x,feedSpec:n,onClose:()=>l(void 0)}),(0,oe.jsx)(C.D,{variant:"finale",semanticColor:"textSubdued",children:p.ag.get("live_events.disclaimer")}),g&&g.userLocationGeonameId&&(0,oe.jsx)(Ze,{geonameId:g.userLocationGeonameId,locationName:x})]})})),en=(0,a.memo)((e=>{const{spec:t,layout:n}=e,a=(0,le.useQuery)("savedConcerts",ge,{keepPreviousData:!1});return(0,oe.jsxs)(oe.Fragment,{children:[(0,oe.jsx)(L.$,{children:`${p.ag.get("live_events.label")}`}),a.data?.events.length?(0,oe.jsx)(oe.Fragment,{children:(0,oe.jsx)(Gt,{title:p.ag.get("concerts_upcoming"),identifier:"saved",position:0,events:a.data?.events,feedSpec:t,onOpenGroupedEvent:()=>{},layout:n})}):(0,oe.jsxs)("div",{className:we,children:[(0,oe.jsx)(C.D,{as:"h2",variant:"canon",semanticColor:"textBase",className:Pe,children:p.ag.get("concerts_interested_in_live_events")}),(0,oe.jsx)(C.D,{as:"p",className:Oe,children:p.ag.get("concerts_no_events_description")}),(0,oe.jsx)(R.default,{to:"/concerts",className:Ee,children:(0,oe.jsx)(I.P,{as:"span",className:Ue,children:p.ag.get("concerts_browse_more_events")})})]}),(0,oe.jsx)(C.D,{variant:"finale",semanticColor:"textSubdued",children:p.ag.get("live_events.disclaimer")})]})})),tn=(0,a.memo)((e=>{const{spec:t,isLoading:n,data:a,onOpenGroupedEvent:s,layout:o,locationName:i}=e;if(n)return(0,oe.jsx)(w.h,{hasError:!1,errorMessage:""});if(!a||0===a.events.length)return(0,oe.jsxs)("div",{className:we,children:[(0,oe.jsx)(C.D,{as:"h2",variant:"canon",semanticColor:"textBase",className:Pe,children:p.ag.get("concerts.no_spotify_results_title")}),(0,oe.jsx)(C.D,{as:"p",className:Oe,children:p.ag.get("concerts.no_spotify_results_description")})]});const r=(e=>{const t={near:[],other:[]};return e.forEach((e=>{switch(e.source){case"near_first_party":t.near.push(e);break;case"other_first_party":t.other.push(e)}})),t})(a.events);return(0,oe.jsxs)(oe.Fragment,{children:[(0,oe.jsx)(Gt,{title:p.ag.get("concerts.spotify_concerts_near",i),identifier:"spotify_near",position:0,events:r.near,feedSpec:t,onOpenGroupedEvent:s,layout:o}),(0,oe.jsx)(Gt,{title:p.ag.get("concerts.header.other"),identifier:"spotify_other",position:1,events:r.other,feedSpec:t,onOpenGroupedEvent:s,layout:o})]})})),nn=(0,a.memo)((e=>{const{geonameId:t,spec:n,layout:s,onLocationNameChange:r}=e,c=(0,o.s0)(),[l]=(0,i.lr)(),d=(0,ke.o)(),{data:m,isLoading:g}=(e=>(0,le.useQuery)(["concerts","spotify",{geonameId:e}],pe,{staleTime:xe,keepPreviousData:!0}))(t),[u,v]=(0,a.useState)(),h=(0,a.useMemo)((()=>n.headerFactory()),[n]);(0,a.useEffect)((()=>{m?.userLocation&&r?.(m.userLocation)}),[m?.userLocation,r]);const x=m?.userLocation||p.ag.get("concerts.default_location");return(0,oe.jsxs)("div",{children:[(0,oe.jsx)(L.$,{children:`${p.ag.get("live_events.label")}`}),(0,oe.jsx)("div",{className:Re,"data-testid":"location-selector",children:(0,oe.jsx)(Ne.Z,{handleLocationChange:e=>{d({type:"click",intent:"change-live-events-location"}),e?.geonameId&&c({pathname:(0,A.yI)(e.geonameId,e.location),search:`?${l}`})},locationStr:x,headerSpec:h})}),(0,oe.jsx)(tn,{spec:n,data:m,isLoading:g,onOpenGroupedEvent:e=>{v(e);const t=e.concerts[0]?.concert.artistUris[0];d({type:"click",intent:"open-grouped-live-event",targetUri:t})},layout:s,locationName:x}),(0,oe.jsx)(re,{event:u,locationName:x,feedSpec:n,onClose:()=>v(void 0)}),(0,oe.jsx)(C.D,{variant:"finale",semanticColor:"textSubdued",children:p.ag.get("live_events.disclaimer")}),m&&m.userLocationGeonameId&&(0,oe.jsx)(Ze,{geonameId:m.userLocationGeonameId,locationName:x})]})})),an=r.vI0,sn={url:"https://tickets.spotifycdn.com/partner-assets/Hub%20header%20image/Desktop%20header%20IMG.png",width:2736,height:720},on=()=>{const{isAnonymous:e}=(0,s.v9)(N.Gg),t=(0,o.TH)(),n=t.pathname+t.search,r=(0,k.$P)(),D=(0,v.W6)(_.tp),[C,I]=(0,a.useState)("grid"),{spec:S}=(0,k.fU)(h.y,{}),b=ye({isAnonymous:e,isInterestedEnabled:D}),L=(0,a.useMemo)((()=>S.headerFactory().liveEventsNavbarFactory({uri:n,reason:b.type})),[S,b,n]),F=(0,k.Wi)(L),[w,E]=(0,a.useState)(),U=e=>{const n=`${t.pathname}?filter=${e}`,a=S.headerFactory().liveEventsNavbarFactory({uri:n,reason:e}).hitUiNavigate({destination:n});r.logInteraction(a)},P=()=>{const e=S.headerFactory().layoutToggleFactory().hitToggleState({stateBeforeToggle:C,stateAfterToggle:"grid"===C?"list":"grid"});r.logInteraction(e),I("grid"===C?"list":"grid")},O=e&&w?p.ag.get("live_events.location_concert_tickets",w):p.ag.get("live_events.label");return(0,oe.jsxs)("section",{className:De,children:[(0,oe.jsxs)(j.gF,{size:j.fR.SMALL,backgroundColor:an,backgroundImages:[sn],children:[(0,oe.jsx)(j.sP,{children:(0,oe.jsx)(j.xd,{children:O})}),(0,oe.jsx)(f.W,{children:(0,oe.jsx)(y.i,{text:O})})]}),(0,oe.jsxs)("div",{className:Ce,children:[(0,oe.jsx)(x.I,{backgroundColor:an}),(0,oe.jsxs)("div",{className:Le,ref:F,children:[(0,oe.jsx)(c.l,{list:(0,oe.jsx)("nav",{"aria-label":"live events navbar",children:(0,oe.jsxs)(l.F,{children:[(0,oe.jsx)(d.c,{id:"for_you_link",label:p.ag.get("live_events.for_you_tab"),active:"foryou"===b.type,className:Fe,component:i.rU,onClick:()=>U("foryou"),sentenceCase:!0,to:{search:"filter=foryou"}},"foryou"),(0,oe.jsx)(d.c,{id:"concerts_all_link",label:p.ag.get("live_events.all_events_tab"),active:"all"===b.type,className:Fe,component:i.rU,onClick:()=>U("all"),sentenceCase:!0,to:{search:"filter=all"}},"all"),!e&&D&&(0,oe.jsx)(d.c,{id:"concerts_interested_link",label:p.ag.get("concerts_interested"),active:"saved"===b.type,className:Fe,component:i.rU,onClick:()=>U("saved"),sentenceCase:!0,to:{search:"filter=saved"}},"saved")]})})}),"grid"===C&&(0,oe.jsx)(m.o,{"aria-label":p.ag.get("concerts.feed_list_layout"),iconOnly:g.d,className:be,onClick:P,size:"small"}),"list"===C&&(0,oe.jsx)(m.o,{"aria-label":p.ag.get("concerts.feed_grid_layout"),iconOnly:u.z,className:be,onClick:P,size:"small"})]}),(0,oe.jsxs)("div",{className:Ie,children:[e&&"foryou"===b.type&&(0,oe.jsx)(Bt,{geonameId:b.geonameId,spec:S,layout:C,onLocationNameChange:E}),!e&&"foryou"===b.type&&(0,oe.jsx)(Yt,{geonameId:b.geonameId,spec:S,layout:C,onLocationNameChange:E}),"all"===b.type&&(0,oe.jsx)(Et,{geonameId:b.geonameId,spec:S,layout:C,onLocationNameChange:E}),"first_party"===b.type&&(0,oe.jsx)(nn,{geonameId:b.geonameId,spec:S,layout:C,onLocationNameChange:E}),"saved"===b.type&&(0,oe.jsx)(en,{spec:S,layout:C})]})]})]})}}}]);
//# sourceMappingURL=xpui-routes-collection-concerts.js.map