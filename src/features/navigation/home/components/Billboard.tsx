import { Button } from '@/components/ui/button'
import AuthState from '../../../authentication/AuthState'
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "@/components/ui/table"
import { FaUpload } from 'react-icons/fa'


function Billboard() {
    return (
        <>
            <div className="">
                < AuthState />
                <Table>
                    <TableCaption>BillBoard</TableCaption>
                    <TableHeader>
                        <TableRow>
                            <TableHead className="w-[100px]">SOURCE</TableHead>
                            <TableHead>STATUS</TableHead>
                            <TableHead>NOTORIETY</TableHead>
                            <TableHead className="text-right">UPVOTE</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        <TableRow>
                            <TableCell className="font-medium">BBC</TableCell>
                            <TableCell>Active</TableCell>
                            <TableCell>9.8</TableCell>
                            <TableCell className="text-center">
                                <Button>
                                    <FaUpload/>   
                                </Button>
                            </TableCell>
                        </TableRow>
                    </TableBody>
                </Table>

            </div>

        </>
    )
}

export default Billboard